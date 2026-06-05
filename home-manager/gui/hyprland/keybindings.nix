{
  lib,
  pkgs,
  ...
}: let
  mod = "SUPER";
  ROOT = builtins.toString ./.;
  lua = lib.generators.mkLuaInline;

  bind = keys: dispatcher: {
    _args = [
      keys
      (lua dispatcher)
    ];
  };
  bindWith = keys: dispatcher: opts: {
    _args = [
      keys
      (lua dispatcher)
      opts
    ];
  };
  exec = command: "hl.exec_cmd([[${command}]])";
  dispatch = dispatcher: arg: exec "${pkgs.hyprland}/bin/hyprctl dispatch ${dispatcher} ${arg}";

  repeatLocked = {
    locked = true;
    repeating = true;
  };
  locked = {
    locked = true;
  };
in {
  bind =
    [
      # focus movement
      (bind "${mod} + H" ''hl.dsp.focus( { direction = "left" } )'')
      (bind "${mod} + J" ''hl.dsp.focus( { direction = "down" } )'')
      (bind "${mod} + K" ''hl.dsp.focus( { direction = "up" } )'')
      (bind "${mod} + L" ''hl.dsp.focus( { direction = "right" } )'')

      # swap containers and workspaces
      (bind "${mod} + S" (exec "sh ${ROOT}/swap_containers.sh"))
      (bind "${mod} + SHIFT + S" (exec "sh ${ROOT}/swap_workspaces.sh"))

      # move window
      (bind "${mod} + SHIFT + H" ''hl.dsp.window.move( { direction = "left" } )'')
      (bind "${mod} + SHIFT + J" ''hl.dsp.window.move( { direction = "down" } )'')
      (bind "${mod} + SHIFT + K" ''hl.dsp.window.move( { direction = "up" } )'')
      (bind "${mod} + SHIFT + L" ''hl.dsp.window.move( { direction = "right" } )'')

      # launchers
      (bind "${mod} + SHIFT + RETURN" (exec "${pkgs.rofi}/bin/rofi -show drun"))
      (bind "${mod} + D" (exec "${pkgs.rofi}/bin/rofi -show run"))
      (bind "${mod} + SHIFT + Q" (exec "${pkgs.wlogout}/bin/wlogout"))
      (bind "${mod} + CTRL + L" (exec "${pkgs.hyprlock}/bin/hyprlock"))

      # window actions
      (bind "${mod} + Q" "hl.dsp.window.kill()")
      (bind "${mod} + F" "hl.dsp.window.fullscreen()")
      (bind "${mod} + TAB" (dispatch "workspace" "previous"))

      # apps
      (bind "${mod} + B" (exec "firefox"))
      (bind "${mod} + M" (exec "${pkgs.thunderbird}/bin/thunderbird"))
      (bind "${mod} + E" (exec "${pkgs.alacritty}/bin/alacritty -e ${pkgs.yazi}/bin/yazi"))
      (bind "${mod} + RETURN" (exec "${pkgs.alacritty}/bin/alacritty"))

      # clipboard
      (bind "${mod} + V" (
        exec "${pkgs.cliphist}/bin/cliphist list | ${pkgs.rofi}/bin/rofi -dmenu | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy"
      ))

      # screenshots
      (bind "PRINT" (
        exec ''${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" - | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png''
      ))
      (bind "${mod} + SHIFT + PRINT" (
        exec "${pkgs.grim}/bin/grim -o $(${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq -r '.[] | select(.focused) | .name')"
      ))
    ]
    ++ (
      # move container → workspace 1–9
      builtins.concatLists (
        builtins.genList (
          i: let
            ws = i + 1;
            key = "code:1${toString i}";
          in [
            (bind "${mod} + ${key}" (dispatch "workspace" (toString ws)))
            (bind "${mod} + SHIFT + ${key}" (dispatch "movetoworkspace" (toString ws)))
          ]
        )
        9
      )
    )
    ++ [
      # brightness
      (
        bindWith "XF86MonBrightnessDown" (exec "${pkgs.brightnessctl}/bin/brightnessctl set 5%-")
        repeatLocked
      )
      (
        bindWith "XF86MonBrightnessUp" (exec "${pkgs.brightnessctl}/bin/brightnessctl set +5%")
        repeatLocked
      )

      # volume
      (bindWith "XF86AudioRaiseVolume" (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+") repeatLocked)
      (bindWith "XF86AudioLowerVolume" (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") repeatLocked)
      (bindWith "XF86AudioMute" (exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") locked)

      # media
      (bindWith "XF86AudioPlay" (exec "${pkgs.playerctl}/bin/playerctl play-pause") locked)
      (bindWith "XF86AudioNext" (exec "${pkgs.playerctl}/bin/playerctl next") locked)
      (bindWith "XF86AudioPrev" (exec "${pkgs.playerctl}/bin/playerctl prev") locked)
    ];
}
