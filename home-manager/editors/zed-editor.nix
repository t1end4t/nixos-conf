{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.unstable.zed-editor;
    userSettings = {
      helix_mode = true;
      relative_line_numbers = true;

      # font family
      ui_font_family = "IntoneMono Nerd Font Propo";
      buffer_font_family = "IntoneMono Nerd Font Propo";

      # font size
      ui_font_size = 15;
      buffer_font_size = 16;
      agent_font_size = 15;
      scrollbar = {
        show = "never";
      };

      terminal = {
        font_size = 15;
        detect_venv = {
          on = {
            "activate_script" = "nushell";
          };
        };

      };

    };

    # custom keymap
    userKeymaps = [
      {
        "context" = "vim_mode == helix_normal && !menu";
        "bindings" = {
          "space x" = "pane::CloseActiveItem";
          "K" = "pane::ActivateNextItem";
          "J" = "pane::ActivatePreviousItem";
          "ctrl-c" = "editor::Cancel";

          # others
          "alt-/" = "workspace::ToggleRightDock";
          "ctrl-m" = "workspace::ToggleBottomDock";
          "ctrl-f" = "workspace::ToggleZoom";
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";

          "ctrl-n" = "pane::SplitVertical";
          "space q" = "pane::CloseAllItems";
          "space e" = "project_panel::ToggleFocus";

          # disable some keybindings
          "escape" = null;
          "up" = null;
          "down" = null;
          "left" = null;
          "right" = null;
          "g n" = null;
          "g p" = null;
        };
      }
      {
        "context" = "Editor && vim_mode == insert && !menu";
        "bindings" = {
          "j k" = "vim::SwitchToNormalMode";
          "ctrl-e" = "editor::Backspace";
          "ctrl-c" = "vim::SwitchToNormalMode";

          # disable some keybindings
          "escape" = null;
          "up" = null;
          "down" = null;
          "left" = null;
          "right" = null;
          "backspace" = null;
        };
      }
      {
        "context" = "Terminal";
        "bindings" = {
          "alt-/" = "workspace::ToggleRightDock";
          "ctrl-m" = "workspace::ToggleBottomDock";
          "ctrl-f" = "workspace::ToggleZoom";
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";
        };
      }
      {
        "context" = "ProjectPanel && not_editing";
        "bindings" = {
          "alt-/" = "workspace::ToggleRightDock";
          "ctrl-m" = "workspace::ToggleBottomDock";
          "ctrl-f" = "workspace::ToggleZoom";
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "workspace::ActivatePaneDown";

          "ctrl-c" = "project_panel::ToggleFocus";
          "escape" = null;
        };
      }
      {
        "context" = "AgentPanel";
        "bindings" = {
          "alt-/" = "workspace::ToggleRightDock";
          "ctrl-e" = "editor::Backspace";
          "ctrl-w" = "editor::DeleteToPreviousWordStart";
        };
      }
      # replace esc with ctrl-c
      {
        "context" = "VimControl && !menu";
        "bindings" = {
          "ctrl-c" = "vim::SwitchToNormalMode";
          "escape" = null;
        };
      }
      {
        "context" = "vim_mode == normal";
        "bindings" = {
          "ctrl-c" = "vim::SwitchToNormalMode";
          "escape" = null;
        };
      }
      {
        "context" = "vim_mode == normal";
        "bindings" = {
          "ctrl-c" = "editor::Cancel";
          "escape" = null;
        };
      }
      {
        "context" = "vim_mode == visual";
        "bindings" = {
          "ctrl-c" = "vim::SwitchToNormalMode";
          "escape" = null;
        };
      }
      {
        "context" = "vim_mode == insert";
        "bindings" = {
          "ctrl-c" = "vim::NormalBefore";
          "escape" = null;
        };
      }
      {
        "context" = "BufferSearchBar && !in_replace";
        "bindings" = {
          "ctrl-c" = "buffer_search::Dismiss";
          "escape" = null;
        };
      }
      {
        "context" = "BufferSearchBar && !in_replace";
        "bindings" = {
          "ctrl-c" = "buffer_search::Dismiss";
          "escape" = null;
        };
      }

    ];

  };

  # enable api setup
  services.gnome-keyring.enable = true;
}
