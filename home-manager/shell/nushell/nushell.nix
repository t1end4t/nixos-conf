{ nushell-defaultConfig, pkgs, ... }:
let
  extraConfig = builtins.replaceStrings
    [ "exec ^zellij" "^zellij" ]
    [ "exec ${pkgs.zellij}/bin/zellij" "^${pkgs.zellij}/bin/zellij" ]
    (builtins.readFile ./configExtra.nu);
  ROOT = toString ./.;
in
{
  programs.nushell = {
    enable = true;
    configFile.source = "${nushell-defaultConfig}/crates/nu-utils/src/default_files/default_config.nu";
    envFile.source = "${nushell-defaultConfig}/crates/nu-utils/src/default_files/default_env.nu";

    extraConfig = ''
      ${extraConfig}
    '';
    extraEnv = builtins.readFile ./envExtra.nu;
  };
}
