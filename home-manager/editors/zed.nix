{ pkgs, ... }:
{

  # programs.zed-editor = {
  #   enable = true;
  #   package = pkgs.unstable.zed-editor;
  #   # extensions = [
  #   #   "nix"
  #   #   "toml"
  #   #   "rust"
  #   # ];
  #   # userSettings = {
  #   #   theme = {
  #   #     mode = "system";
  #   #     dark = "One Dark";
  #   #     light = "One Light";
  #   #   };
  #   #   hour_format = "hour24";
  #   #   vim_mode = true;
  #   # };
  # };

  home.packages = with pkgs; [
    unstable.zed-editor
  ];
}
