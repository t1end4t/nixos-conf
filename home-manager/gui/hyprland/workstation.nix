{...}: {
  imports = [./common.nix];

  local.hyprland.wallpaperOutputs = ["DP-3" "HDMI-A-1"];

  local.hyprland.hostConfig = ''
    hl.monitor({
      output = "DP-3",
      mode = "1920x1080@60",
      position = "0x0",
      scale = 1,
    })

    hl.workspace_rule({ workspace = "1", monitor = "DP-3", default = true })

    hl.monitor({
      output = "HDMI-A-1",
      mode = "1360x768@60",
      position = "1920x0",
      scale = 1,
    })
  '';
}
