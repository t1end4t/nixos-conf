{ pkgs, ... }:

let
  mod = "$mod";
  left = "H";
  down = "J";
  up = "K";
  right = "L";
  ROOT = builtins.toString ./.;
in

[
  # focus movement
  "${mod}, ${left}, movefocus, l"
  "${mod}, ${down}, movefocus, d"
  "${mod}, ${up}, movefocus, u"
  "${mod}, ${right}, movefocus, r"

  # move window
  "${mod} SHIFT, ${left}, movewindow, l"
  "${mod} SHIFT, ${down}, movewindow, d"
  "${mod} SHIFT, ${up}, movewindow, u"
  "${mod} SHIFT, ${right}, movewindow, r"

  # brightness
  ", XF86MonBrightnessDown, exec, ${pkgs.light}/bin/light -U 5"
  ", XF86MonBrightnessUp, exec, ${pkgs.light}/bin/light -A 5"

  # volume
  ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
  ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
  ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

  # media
  ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
  ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
  ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl prev"

  # launchers
  "${mod} SHIFT, RETURN, exec, ${pkgs.rofi}/bin/rofi -show drun"
  "${mod} SHIFT, Q, exec, ${pkgs.wlogout}/bin/wlogout"
  "${mod} CTRL, L, exec, ${pkgs.swaylock-effects}/bin/swaylock --clock --indicator"

  # window actions
  "${mod}, Q, killactive"
  "${mod}, F, fullscreen"
  "${mod}, TAB, workspace, previous"

  # apps
  "${mod}, B, exec, firefox"
  "${mod}, M, exec, ${pkgs.thunderbird}/bin/thunderbird"
  "${mod}, D, exec, ${pkgs.rofi}/bin/rofi -show run"
  "${mod}, E, exec, ${pkgs.alacritty}/bin/alacritty -e ${pkgs.yazi}/bin/yazi"
  "${mod}, RETURN, exec, ${pkgs.alacritty}/bin/alacritty"

  # clipboard
  "${mod}, V, exec, ${pkgs.cliphist}/bin/cliphist list | ${pkgs.rofi}/bin/rofi -dmenu | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy"

  # scripts
  "${mod}, S, exec, ${ROOT}/swap_container.sh"
  "${mod} SHIFT, S, exec, ${ROOT}/swap_workspaces.sh"

  # screenshots
  ", PRINT, exec, ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -d)\" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png"
  "${mod} SHIFT, PRINT, exec, ${pkgs.grim}/bin/grim -o $(${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq -r '.[] | select(.focused) | .name')"
]
++ (
  # move container → workspace 1–9
  builtins.concatLists (
    builtins.genList (
      i:
      let
        ws = i + 1;
        key = "code:1${toString i}";
      in
      [
        "${mod}, ${key}, workspace, ${toString ws}"
        "${mod} SHIFT, ${key}, movetoworkspace, ${toString ws}"
      ]
    ) 9
  )
)
