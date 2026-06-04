{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprsunset.nix
  ];

  options.local.hyprland.hostConfig = lib.mkOption {
    type = lib.types.lines;
    default = "";
  };

  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      xwayland.enable = true;
    };

    xdg.configFile."hypr/hyprland.lua".text = import ./hyprland-lua.nix {
      inherit pkgs;
      hostConfig = config.local.hyprland.hostConfig;
    };
  };
}
