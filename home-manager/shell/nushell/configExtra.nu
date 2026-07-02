# -----------------------------------------------------
# ADD MORE CONFIG
# -----------------------------------------------------
# atuin
$env.config = {
    show_banner: false
    keybindings: []
}
source ~/.local/share/atuin/init.nu

# add to PATH
$env.PATH = (
  $env.PATH
  | split row (char esep)
  | append [~/.npm-global/bin ~/.local/bin ~/.bun/bin ~/.cargo/bin ~/.opencode/bin]
  | uniq
)

# zoxide
source ~/.zoxide.nu

# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------

def h [file?: string] {
    if $file == null {
        hx $env.PWD
    } else {
        hx $file
    }
}
def l [] {ls | sort-by type}
alias c = clear
alias e = exit
alias yy = yazi
alias g = lazygit
alias tp = trash-put
alias bt = bluetuith
def ld [level: int = 2] {
    eza -DR --tree --level=($level | into string)
}
alias wifi = nmtui
alias about = fastfetch

# -----------------------------------------------------
# GIT
# -----------------------------------------------------

alias gs = git status
alias ga = git add
alias gc = git clone --recurse-submodules
alias gcm = git commit -m
alias gp = git push
alias gpl = git pull
alias gst = git stash
alias gcheck = git checkout

# custom prompt
# $env.PROMPT_COMMAND = {||
#     let dir = (pwd)
#     let home = $nu.home-path
#     let shown = ($dir | str replace $home "~")
#     (ansi cyan_bold) + $shown + (ansi reset)
# }

# -----------------------------------------------------
# ZELLIJ: project sessions (VSCode-like)
#   Win+Enter -> opens last/current session (or "main")
#   zj [name] -> create/switch to a named project session
# -----------------------------------------------------
$env.ZELLIJ_CURRENT = ($nu.data-dir | path join "zellij-current")

def --env zj [name?: string] {
  if not ($env.ZELLIJ_CURRENT | path dirname | path exists) {
    mkdir ($env.ZELLIJ_CURRENT | path dirname)
  }
  let s = if $name == null {
    let sessions = (^zellij list-sessions | lines | each { |l|
      $l | str replace -r ' \(EXITED\)' "" | str replace -r ' \(CREATED\)' "" | str trim
    })
    if not ($sessions | is-empty) { $sessions | print }
    print "Pick a session (or new name):"
    input
  } else { $name }

  if ($s | is-empty) { return }
  $s | save -f $env.ZELLIJ_CURRENT

  if "ZELLIJ" in $env {
    ^zellij attach $s --create-background
    ^zellij action switch-session $s
  } else {
    exec ^zellij attach $s --create
  }
}

# auto-start zellij on fresh interactive terminal
if $nu.is-interactive and (not ("ZELLIJ" in $env)) {
  let session = if ($env.ZELLIJ_CURRENT | path exists) {
    open $env.ZELLIJ_CURRENT | str trim
  } else { "main" }
  exec ^zellij attach $session --create
}
