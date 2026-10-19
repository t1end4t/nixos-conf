#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "usage: codex-run NAME 'COMMAND'" >&2
  exit 2
fi
name=$1
command=$2
case $name in '' | *[!A-Za-z0-9_-]*)
  echo "codex-run: NAME must match [A-Za-z0-9_-]+" >&2
  exit 2
  ;;
esac

pid=$PPID
while [ "${pid:-0}" -gt 1 ] && [ -z "${ZELLIJ_SESSION_NAME:-}${ORCA_TERMINAL_HANDLE:-}" ]; do
  while IFS= read -r -d '' var; do
    case $var in ZELLIJ=* | ZELLIJ_SESSION_NAME=* | ZELLIJ_PANE_ID=* | XDG_RUNTIME_DIR=* | ORCA_TERMINAL_HANDLE=* | ORCA_CLI_BIN_DIR=*) export "${var?}" ;; esac
  done 2>/dev/null <"/proc/$pid/environ" || true
  next=
  while read -r key value; do [ "$key" = PPid: ] && next=$value; done 2>/dev/null <"/proc/$pid/status" || true
  pid=$next
done

if [ -z "${ZELLIJ_SESSION_NAME:-}${ORCA_TERMINAL_HANDLE:-}" ]; then
  echo "codex-run: no Zellij or Orca terminal found; run inside one" >&2
  exit 1
fi

t() { tmux -L codex "$@"; }
if t has-session -t "=$name:" 2>/dev/null; then
  echo "codex-run: '$name' already exists; choose another name" >&2
  exit 1
fi

environment_file=$(mktemp)
export -p >"$environment_file"
# shellcheck disable=SC2016 # Inner bash expands $1, $2, and $BASH.
if ! t -f /dev/null start-server \; set -g remain-on-exit on \; set -g status off \; set -g history-limit 100000 \; \
  new-session -d -s "$name" -c "$PWD" -- env -i "$BASH" --noprofile --norc -c \
    'source "$1" && rm -- "$1" && exec "$BASH" --noprofile --norc -c "$2"' bash "$environment_file" "$command"; then
  rm -- "$environment_file"
  exit 1
fi

attach="$(command -v tmux) -L codex attach -t '=$name:'"
state_dir=${XDG_RUNTIME_DIR:-${XDG_STATE_HOME:-$HOME/.local/state}}/codex-run
mkdir -p "$state_dir" && chmod 700 "$state_dir"
context=$(printf '%s\0' "${ZELLIJ_SESSION_NAME:-}" "${ZELLIJ_PANE_ID:-0}" "${ORCA_TERMINAL_HANDLE:-}" | sha256sum)
state=$state_dir/${context%% *}
exec 9>"$state.lock"
flock 9

zellij_viewer() {
  local last direction=right pane
  last=$(cat "$state" 2>/dev/null || true)
  if [ -n "$last" ] && zellij --session "$ZELLIJ_SESSION_NAME" action list-panes --json |
    jq -e --arg id "${last#terminal_}" 'any(.[]; .is_plugin == false and (.id | tostring) == $id and .is_suppressed == false)' >/dev/null; then
    export ZELLIJ_PANE_ID=${last#terminal_}
    direction=down
  fi
  pane=$(zellij --session "$ZELLIJ_SESSION_NAME" run --no-focus --direction "$direction" --name "codex: $name" -- sh -c "$attach") || return 1
  [[ $pane =~ ^terminal_[0-9]+$ ]] || return 1
  printf '%s\n' "$pane" >"$state"
  viewer_pane=$pane
}

orca_viewer() {
  local orca=${ORCA_CLI_BIN_DIR:?Orca CLI directory missing}/orca
  local last target=$ORCA_TERMINAL_HANDLE direction=vertical before new="" tab reply
  reply=$("$orca" terminal show --terminal "$ORCA_TERMINAL_HANDLE" --json) || return 1
  tab=$(jq -er '.result.terminal.tabId' <<<"$reply") || return 1
  last=$(cat "$state" 2>/dev/null || true)
  handles() { "$orca" terminal list --json | jq -r --arg tab "$tab" '.result.terminals[] | select(.tabId == $tab and .connected == true) | .handle' | sort -u; }
  before=$(handles) || return 1
  if [ -n "$last" ] && [[ $'\n'$before$'\n' == *$'\n'"$last"$'\n'* ]]; then
    target=$last direction=horizontal
  fi
  # ponytail: Orca 1.4.227 replies time out; use the returned handle once upstream fixes timing.
  "$orca" terminal split --terminal "$target" --direction "$direction" --command "$attach" 9>&- >/dev/null 2>&1 &
  for _ in {1..50}; do
    sleep 0.2
    new=$(comm -13 <(printf '%s\n' "$before") <(handles))
    [[ $new != *$'\n'* ]] || return 1
    [ -n "$new" ] && break
  done
  [ -n "$new" ] || return 1
  printf '%s\n' "$new" >"$state"
  viewer_pane=$new
}

if [ -n "${ORCA_TERMINAL_HANDLE:-}" ]; then viewer=orca_viewer; else viewer=zellij_viewer; fi
"$viewer" || {
  echo "codex-run: viewer failed; job still exists. Attach with: $attach" >&2
  exit 1
}

close_when_done() {
  local status
  while status=$(t display -p -t "=$name:" '#{pane_dead} #{pane_dead_status}'); do
    case $status in
      '1 0')
        if [ "$viewer" = orca_viewer ]; then
          "$ORCA_CLI_BIN_DIR/orca" terminal close --terminal "$viewer_pane"
        else
          zellij --session "$ZELLIJ_SESSION_NAME" action close-pane --pane-id "$viewer_pane"
        fi
        return
        ;;
      1\ *) return ;;
    esac
    sleep 1
  done
}
close_when_done 9>&- </dev/null >/dev/null 2>&1 &

cat <<MSG
started: $name
view:    $attach
read:    tmux -L codex capture-pane -pJ -S -200 -t '=$name:'
status:  tmux -L codex display -p -t '=$name:' '#{pane_dead} #{pane_dead_status}'
MSG
