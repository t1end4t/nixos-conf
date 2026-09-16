{
  config,
  lib,
  pkgs,
  ...
}:
let
  mountPoint = "${config.home.homeDirectory}/GoogleDrive";
  cacheDir = "${config.xdg.cacheHome}/rclone";
  configFile = "${config.xdg.configHome}/rclone/rclone.conf";
in
{
  home.packages = [ pkgs.rclone ];

  systemd.user.services.rclone-gdrive = {
    Unit = {
      Description = "Mount Google Drive with rclone";
      Documentation = "https://rclone.org/commands/rclone_mount/";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
      ConditionPathExists = configFile;
    };

    Service = {
      Type = "notify";
      Environment = "PATH=/run/wrappers/bin:${lib.makeBinPath [ pkgs.fuse3 ]}";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${lib.escapeShellArg mountPoint} ${lib.escapeShellArg cacheDir}";
      ExecStart = "${lib.getExe pkgs.rclone} mount gdrive: ${lib.escapeShellArg mountPoint} --config ${lib.escapeShellArg configFile} --cache-dir ${lib.escapeShellArg cacheDir} --vfs-cache-mode full --log-systemd";
      ExecStop = "/run/wrappers/bin/fusermount3 -u ${lib.escapeShellArg mountPoint}";
      Restart = "on-failure";
      RestartSec = "10s";
    };

    Install.WantedBy = [ "default.target" ];
  };
}
