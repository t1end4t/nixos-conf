{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.unstable.zed-editor;
    extensions = [
      "nix"
      "toml"
      "git-firefly"
    ];
    userSettings = {
      terminal = {
        detect_venv = "off";
      };
      helix_mode = true;
      relative_line_numbers = true;
      show_wrap_guides = true;
      wrap_guides = [ 80 ];
      scrollbar = {
        show = "never";
      };
      cursor_blink = false;

      # languages setup
      languages = {
        "Python" = {
          language_servers = [
            "!basedpyright"
            "pyright"
            "ruff"
          ];
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
        };
      };

    };
  };

  # enable keyring
  services.gnome-keyring.enable = true;

  # NOTE: keymap setting (can not set it from programs.zed-editor)
  home.file.".config/zed/keymap.json" = {
    source = "${ROOT}/keymap.json";
  };
}
