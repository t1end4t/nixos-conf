{ pkgs, ... }:
{
  # for login and remember key
  services.gnome-keyring.enable = true;

  # Provides org.gnome.keyring.SystemPrompter
  home.packages = [ pkgs.gcr ];

  programs.zed-editor = {
    enable = true;
    package = pkgs.unstable.zed-editor;
    userSettings = {
      helix_mode = true;
      scrollbar = {
        show = "never";
      };

      languages = {
        Python = {
          formatter = {
            external = {
              command = "ruff";
              arguments = [
                "format"
                "-"
                "--line-length"
                "80"
              ];
            };
          };
          format_on_save = "on";
        };
      };
    };
  };
}
