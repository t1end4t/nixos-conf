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
      "baml"
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

      # agent setup
      # disable_ai = true;
      agent = {
        default_model = {
          provider = "openrouter";
          model = "anthropic/claude-sonnet-4";
        };

        inline_assistant_model = {
          provider = "openrouter";
          model = "qwen/qwen3-coder";
        };

        commit_message_model = {
          provider = "google";
          model = "gemini-2.0-flash";
        };

        thread_summary_model = {
          provider = "google";
          model = "gemini-2.0-flash";
        };
      };
    };
  };

  # enable keyring
  # services.gnome-keyring.enable = true;

  # NOTE: keymap setting (can not set it from programs.zed-editor)
  home.file.".config/zed/keymap.json" = {
    source = "${ROOT}/keymap.json";
  };
}
