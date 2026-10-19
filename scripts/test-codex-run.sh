#!/usr/bin/env bash
set -euo pipefail

launcher=$(cd "$(dirname "$0")" && pwd)/codex-run.sh
temp=$(mktemp -d)
names=()
cleanup() {
  for n in "${names[@]}"; do tmux -L codex kill-session -t "=$n:" 2>/dev/null || true; done
  rm -rf "$temp"
}
trap cleanup EXIT
run() { names+=("$1"); bash "$launcher" "$@" >/dev/null; }

cat >"$temp/zellij" <<'FAKE'
#!/bin/sh
printf '%s\n' "$*" >>"$LOG"
n=$(grep -c -e ' run ' -e ' split ' "$LOG")
case "$*" in
  *' run '*) echo "terminal_$n" ;;
  *list-panes*) echo '[{"id":1,"is_plugin":false,"is_suppressed":false}]' ;;
  *'terminal show'*) echo '{"result":{"terminal":{"tabId":"test"}}}' ;;
  *'terminal split'*) echo "term_$n" >>"$LOG.handles" ;;
  *'terminal list'*) { printf '%s\n' term_agent; cat "$LOG.handles" 2>/dev/null || true; } | jq -Rn '{result:{terminals:[inputs | {handle:.,tabId:"test",connected:true}]}}' ;;
esac
FAKE
chmod +x "$temp/zellij"
cp "$temp/zellij" "$temp/orca"
export PATH="$temp:$PATH" XDG_RUNTIME_DIR=$temp LOG=$temp/log LAUNCHER_TEST_VALUE='value with spaces'
id=$$

if bash "$launcher" bad.name true >/dev/null 2>&1; then exit 1; fi

# Zellij: job output, cwd, env, exit status; first viewer right, second below it.
cd "$temp"
ZELLIJ_SESSION_NAME=s run "z1-$id" 'printf "%s\n" "$PWD" "$LAUNCHER_TEST_VALUE"; exit 7'
ZELLIJ_SESSION_NAME=s run "z2-$id" true
for _ in {1..50}; do [ "$(tmux -L codex display -p -t "=z1-$id:" '#{pane_dead}')" = 1 ] && break; sleep 0.1; done
[ "$(tmux -L codex display -p -t "=z1-$id:" '#{pane_dead_status}')" = 7 ]
output=$(tmux -L codex capture-pane -pJ -S -200 -t "=z1-$id:")
[[ $output == *"$temp"* && $output == *'value with spaces'* ]]
grep ' run ' "$LOG" | sed -n 1p | grep -- '--direction right' >/dev/null
grep ' run ' "$LOG" | sed -n 2p | grep -- '--direction down' >/dev/null
for _ in {1..50}; do grep -q 'action close-pane --pane-id terminal_2' "$LOG" && break; sleep 0.1; done
grep -q 'action close-pane --pane-id terminal_2' "$LOG"
if grep -q 'action close-pane --pane-id terminal_1' "$LOG"; then exit 1; fi
[ "$(tmux -L codex display -p -t "=z2-$id:" '#{pane_dead} #{pane_dead_status}')" = '1 0' ]
if ZELLIJ_SESSION_NAME=s bash "$launcher" "z1-$id" true >/dev/null 2>&1; then exit 1; fi

# Orca: first split beside agent, second stacked under the first viewer.
: >"$LOG"
ORCA_TERMINAL_HANDLE=term_agent ORCA_CLI_BIN_DIR=$temp run "o1-$id" true
ORCA_TERMINAL_HANDLE=term_agent ORCA_CLI_BIN_DIR=$temp run "o2-$id" 'exit 7'
grep 'terminal split' "$LOG" | sed -n 1p | grep -- '--terminal term_agent --direction vertical' >/dev/null
grep 'terminal split' "$LOG" | sed -n 2p | grep -- '--terminal term_1 --direction horizontal' >/dev/null
ZELLIJ_SESSION_NAME=inherited ORCA_TERMINAL_HANDLE=term_agent ORCA_CLI_BIN_DIR=$temp run "o3-$id" true
grep 'terminal split' "$LOG" | sed -n 3p | grep -- '--direction vertical' >/dev/null
for _ in {1..50}; do grep -q 'terminal close --terminal term_3' "$LOG" && break; sleep 0.1; done
grep -q 'terminal close --terminal term_1' "$LOG"
grep -q 'terminal close --terminal term_3' "$LOG"
if grep -q 'terminal close --terminal term_2' "$LOG"; then exit 1; fi
[ "$(tmux -L codex display -p -t "=o1-$id:" '#{pane_dead} #{pane_dead_status}')" = '1 0' ]

# Viewer failure keeps the job.
printf '#!/bin/sh\nexit 1\n' >"$temp/zellij"
names+=("f-$id")
if ZELLIJ_SESSION_NAME=s bash "$launcher" "f-$id" 'sleep 1' >"$temp/failure" 2>&1; then exit 1; fi
grep 'job still exists' "$temp/failure" >/dev/null
tmux -L codex has-session -t "=f-$id:"

# Claude hook: start opens a viewer; stop ends its transcript watcher.
mkdir -p "$temp/project/session/subagents"
printf '%s\n' \
  '{"type":"assistant","message":{"content":[{"type":"text","text":"hook visible"}]}}' \
  '{"type":"assistant","message":{"content":[{"type":"tool_use","name":"Read","input":{"file_path":"INDEX.md"}}]}}' \
  '{"type":"user","message":{"content":[{"type":"tool_result","content":"raw tool result"},{"type":"tool_result","is_error":true,"content":"raw tool error"}]}}' \
  >"$temp/project/session/subagents/agent-a1.jsonl"
mkdir -p "$temp/bin"
export PATH="$temp/bin:$PATH"
cat >"$temp/bin/codex-run" <<'FAKE'
#!/bin/sh
printf '%s\n' "$2" >"$LOG.claude"
FAKE
chmod +x "$temp/bin/codex-run"
ln -s "$(command -v bash)" "$temp/claude"
event='{"session_id":"session","agent_id":"a1","transcript_path":"'"$temp"'/project/session.jsonl","cwd":"'"$temp"'","hook_event_name":"SubagentStart"}'
"$temp/claude" -c 'python3 "$1" <<<"$2"' bash "$(dirname "$launcher")/claude-pane.py" "$event"
watch=$(cat "$LOG.claude")
python3 "$(dirname "$launcher")/claude-pane.py" <<<"${event/SubagentStart/SubagentStop}"
watch_output=$(timeout 5 bash -c "$watch")
[[ $watch_output == *'hook visible'* && $watch_output == *'[subagent finished]'* ]]
[[ $watch_output == *'[Read] INDEX.md'* && $watch_output == *'[tool failed;'* ]]
[[ $watch_output != *'raw tool'* && $watch_output != *'"file_path"'* ]]

# Session shutdown ends remaining watchers; invalid IDs cannot escape the state directory.
python3 "$(dirname "$launcher")/claude-pane.py" <<<"${event/SubagentStart/SessionEnd}"
[ -f "$temp/claude-panes/session/session.done" ]
if python3 "$(dirname "$launcher")/claude-pane.py" <<<"${event/\"a1\"/\"..\"}" 2>/dev/null; then exit 1; fi

# Setup preserves existing settings and hooks; repeated setup never duplicates entries.
mkdir -p "$temp/home/.claude" "$temp/home/.codex"
printf '%s\n' '{"env":{"EXISTING":"keep"},"hooks":{"SubagentStart":[{"hooks":[{"type":"command","command":"keep-me"}]}]}}' >"$temp/home/.claude/settings.json"
printf 'Keep these instructions.\n' >"$temp/home/.codex/AGENTS.md"
printf '## Visible Background Commands\n\n- Completed panes remain visible.\n' >"$temp/home/.claude/CLAUDE.md"
for _ in 1 2; do HOME="$temp/home" python3 "$(dirname "$launcher")/setup-agent-panes.py" 'python /test/claude-pane.py' >/dev/null; done
jq -e '.env.EXISTING == "keep" and (.hooks.SubagentStart | length) == 2 and .hooks.SubagentStart[0].hooks[0].command == "keep-me"' "$temp/home/.claude/settings.json" >/dev/null
[ "$(grep -c '## Visible Background Commands' "$temp/home/.codex/AGENTS.md")" = 1 ]
grep 'Keep these instructions.' "$temp/home/.codex/AGENTS.md" >/dev/null
grep 'Successful jobs close their viewer panes automatically' "$temp/home/.claude/CLAUDE.md" >/dev/null
if grep -q 'Completed panes remain visible' "$temp/home/.claude/CLAUDE.md"; then exit 1; fi
printf 'codex-run checks passed\n'
