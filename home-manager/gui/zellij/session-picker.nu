let result = (zellij list-sessions --short --no-formatting | fzf --prompt 'zellij session> ' --print-query --bind 'enter:accept-non-empty' | lines)
let query = ($result | get --optional 0 | default '' | str trim)
let selected = ($result | get --optional 1 | default '' | str trim)
let session = (if not ($selected | is-empty) { $selected } else { $query })

if not ($session | is-empty) {
    mkdir ~/.local/state/zellij
    $session | save -f ~/.local/state/zellij/latest
    if not ($selected | is-empty) {
        zellij action switch-session $session
    } else {
        zellij --session $session
    }
}
