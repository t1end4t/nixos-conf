let session = (zellij list-sessions --short --no-formatting | fzf --prompt 'zellij session> ' | str trim)

if not ($session | is-empty) {
    mkdir ~/.local/state/zellij
    $session | save -f ~/.local/state/zellij/latest
    zellij action switch-session $session
}
