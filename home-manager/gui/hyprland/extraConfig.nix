{ pkgs, ... }:

let
  mod = "$mod";
  lock_after = 300;
  off_after = 10;
  lock_cmd = "${pkgs.swaylock-effects}/bin/swaylock --clock --indicator";
in
''
  # workspace press flag
  bind = ${mod}, 1, exec, sh -c "echo 1 > /tmp/sovpipe"
  bind = ${mod}, 2, exec, sh -c "echo 1 > /tmp/sovpipe"
  bind = ${mod}, 3, exec, sh -c "echo 1 > /tmp/sovpipe"
  bind = ${mod}, 4, exec, sh -c "echo 1 > /tmp/sovpipe"
  bind = ${mod}, 5, exec, sh -c "echo 1 > /tmp/sovpipe"
  bind = ${mod}, 6, exec, sh -c "echo 1 > /tmp/sovpipe"
  bind = ${mod}, 7, exec, sh -c "echo 1 > /tmp/sovpipe"
  bind = ${mod}, 8, exec, sh -c "echo 1 > /tmp/sovpipe"
  bind = ${mod}, 9, exec, sh -c "echo 1 > /tmp/sovpipe"
  bind = ${mod}, 0, exec, sh -c "echo 1 > /tmp/sovpipe"

  # workspace release flag
  bindr = ${mod}, 1, exec, sh -c "echo 0 > /tmp/sovpipe"
  bindr = ${mod}, 2, exec, sh -c "echo 0 > /tmp/sovpipe"
  bindr = ${mod}, 3, exec, sh -c "echo 0 > /tmp/sovpipe"
  bindr = ${mod}, 4, exec, sh -c "echo 0 > /tmp/sovpipe"
  bindr = ${mod}, 5, exec, sh -c "echo 0 > /tmp/sovpipe"
  bindr = ${mod}, 6, exec, sh -c "echo 0 > /tmp/sovpipe"
  bindr = ${mod}, 7, exec, sh -c "echo 0 > /tmp/sovpipe"
  bindr = ${mod}, 8, exec, sh -c "echo 0 > /tmp/sovpipe"
  bindr = ${mod}, 9, exec, sh -c "echo 0 > /tmp/sovpipe"
  bindr = ${mod}, 0, exec, sh -c "echo 0 > /tmp/sovpipe"

  # border
  general {
    border_size = 4
  }

  # daemons
  exec-once = autotiling
  exec-once = mako --default-timeout 5000
  exec-once = wl-paste --watch cliphist store
  exec-once = wlsunset -t 0 -l 21.0 -L 105.8
  exec-once = sh -c "rm -f /tmp/sovpipe && mkfifo /tmp/sovpipe && tail -f /tmp/sovpipe | sov -t 500"
  exec-once = sworkstyle
  exec-once = fcitx5
  exec-once = hyprctl setcursor Bibata-Modern-Ice 24
  exec-once = sh -c "sleep 2 && systemctl --user start kanshi.service"
  exec-once = systemctl --user import-environment

  # hide cursor after 3s
  cursor_inactive_timeout = 3

  # idle / lock
  exec-once = swayidle -w \
    timeout ${toString lock_after} '${lock_cmd}' \
    timeout ${toString off_after} 'if pgrep swaylock; then hyprctl dispatch dpms off; fi' \
    resume 'hyprctl dispatch dpms on' \
    before-sleep '${lock_cmd}'

  # idle inhibit
  windowrulev2 = idleinhibit fullscreen, class:^(Firefox)$
  windowrulev2 = idleinhibit fullscreen, class:^(qutebrowser)$
  windowrulev2 = idleinhibit focus, class:^(mpv)$
''
