{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    hyprpaper # for wallpaper
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      "$mod" = "SUPER";
      # terminal = "alacritty";
      bind = [
        "$mod, B, exec, firefox"
        "$mod, F, exec, alacritty"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              # "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 9
        )
      );
    };
  };
}
