{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
  keymap_json = (builtins.readFile "${ROOT}/keymap.json");
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
    userKeymaps = (builtins.fromJSON keymap_json);
    userSettings = {
      terminal = {
        detect_venv = "off";
      };
      helix_mode = true;

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
}
