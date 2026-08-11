{
  config,
  pkgs,
  ...
}: let
  stedgeaiRoot = "${config.home.homeDirectory}/.local/opt/stedgeai/4.0";
in {
  home.packages = with pkgs; [
    gcc-arm-embedded
  ];

  home.sessionVariables.STEDGEAI_CORE_DIR = stedgeaiRoot;
  home.sessionPath = ["${stedgeaiRoot}/Utilities/linux"];
}
