{ pkgs, config, ... }:
let
  ROOT = builtins.toString ./.;
in
# HOME = builtins.getEnv "HOME";
{
  home.packages = with pkgs; [
    unstable.aichat # llm
    argc # for use tools from aichat
  ];

  # template config
  home.file.".config/aichat/config.example.yaml" = {
    source = "${ROOT}/config.example.yaml";
  };

  # roles for specific tasks
  home.file.".config/aichat/roles" = {
    source = "${ROOT}/roles";
    recursive = true;
  };

  # tools and agents for aichat
  home.file.".config/aichat/functions" = {
    source = "${ROOT}/functions";
    recursive = true;
  };

  home.sessionVariables = {
    # for using aichat
    AICHAT_FUNCTIONS_DIR = "${config.home.homeDirectory}/.config/aichat/functions";
    WEB_SEARCH_MODEL = "gemini:gemini-2.0-flash";
  };
}
