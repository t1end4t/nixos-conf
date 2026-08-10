{
  config,
  pkgs,
  ...
}: let
  stedgeaiRoot = "${config.home.homeDirectory}/.local/opt/stedgeai";
in {
  home.packages = with pkgs; [
    gcc-arm-embedded
  ];

  home.sessionVariables.STEDGEAI_CORE_DIR = stedgeaiRoot;
  home.sessionPath = ["${stedgeaiRoot}/Utilities/linux"];
}
