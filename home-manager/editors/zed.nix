{ pkgs, ... }: {
  programs.zed-editor = {
    enable = true;
    package = pkgs.unstable.zed-editor;
    extensions = [
      "nix"
      "toml"
    ];
    userSettings = {
      helix_mode = true;
      middle_click_paste = false;
      current_line_highlight = "line";
      show_wrap_guides = true;
      wrap_guides = [ 80 ];
      preferred_line_length = 110;
      soft_wrap = "preferred_line_length";
      relative_line_numbers = "enabled";
      extend_comment_on_newline = false;
      completions.lsp_insert_mode = "replace";

      terminal.shell.program = "nu";

      indent_guides.enabled = true;

      diagnostics.inline = {
        enabled = true;
        max_severity = "error";
      };

      vim.cursor_shape = {
        insert = "bar";
        normal = "block";
        visual = "underline";
        replace = "underline";
      };
    };
    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          ctrl-m = "terminal_panel::Toggle";
          ctrl-n = "workspace::NewTerminal";
          ctrl-f = "workspace::ToggleZoom";
          ctrl-h = "workspace::ActivatePaneLeft";
          ctrl-j = "workspace::ActivatePaneDown";
          ctrl-k = "workspace::ActivatePaneUp";
          ctrl-l = "workspace::ActivatePaneRight";
        };
      }
      {
        context = "Editor";
        bindings = {
          ctrl-m = "terminal_panel::Toggle";
          ctrl-f = "workspace::ToggleZoom";
          ctrl-h = "workspace::ActivatePaneLeft";
          ctrl-j = "workspace::ActivatePaneDown";
          ctrl-k = "workspace::ActivatePaneUp";
          ctrl-l = "workspace::ActivatePaneRight";
        };
      }
      {
        context = "VimControl && !menu";
        bindings = {
          ctrl-m = "terminal_panel::Toggle";
          ctrl-f = "workspace::ToggleZoom";
          ctrl-h = "workspace::ActivatePaneLeft";
          ctrl-j = "workspace::ActivatePaneDown";
          ctrl-k = "workspace::ActivatePaneUp";
          ctrl-l = "workspace::ActivatePaneRight";
        };
      }
      {
        context = "vim_mode == insert && !menu";
        bindings = {
          up = null;
          down = null;
          left = null;
          right = null;
          escape = null;
          backspace = null;
          ctrl-s = "workspace::Save";
          ctrl-c = "vim::NormalBefore";
          "j k" = "vim::NormalBefore";
          ctrl-e = "editor::Backspace";
        };
      }
      {
        context = "vim_mode == helix_normal && !menu";
        bindings = {
          ctrl-m = "terminal_panel::Toggle";
          ctrl-f = "workspace::ToggleZoom";
          ctrl-h = "workspace::ActivatePaneLeft";
          ctrl-j = "workspace::ActivatePaneDown";
          ctrl-k = "workspace::ActivatePaneUp";
          ctrl-l = "workspace::ActivatePaneRight";
        };
      }
      {
        context = "vim_mode == helix_select && !menu";
        bindings = {
          ctrl-m = "terminal_panel::Toggle";
          ctrl-f = "workspace::ToggleZoom";
          ctrl-h = "workspace::ActivatePaneLeft";
          ctrl-j = "workspace::ActivatePaneDown";
          ctrl-k = "workspace::ActivatePaneUp";
          ctrl-l = "workspace::ActivatePaneRight";
        };
      }
      {
        context = "vim_mode == helix_normal && !menu";
        bindings = {
          up = null;
          down = null;
          left = null;
          right = null;
          escape = null;
          "space a" = "agent::ToggleFocus";
          "space b" = "tab_switcher::ToggleAll";
          "space e" = "project_panel::ToggleFocus";
          "space f" = "file_finder::Toggle";
          "space g" = "git_panel::ToggleFocus";
          "space q" = "workspace::CloseActiveDock";
          "space shift-f" = "file_finder::Toggle";
          "space shift-r" = "editor::Rename";
          "space x" = "pane::CloseActiveItem";
          shift-r = "editor::Paste";
          y = "vim::HelixYank";
          d = "vim::HelixDelete";
          p = "vim::HelixPaste";
          shift-p = [
            "vim::HelixPaste"
            { before = true; }
          ];
          shift-x = "editor::SelectLine";
          enter = "vim::HelixJumpToWord";
          shift-j = "pane::ActivatePreviousItem";
          shift-k = "pane::ActivateNextItem";
          ctrl-s = "workspace::Save";
          alt-j = "editor::MoveLineDown";
          alt-k = "editor::MoveLineUp";
          ctrl-c = "vim::SwitchToHelixNormalMode";
          "g n" = null;
          "g p" = null;
        };
      }
      {
        context = "vim_mode == helix_select && !menu";
        bindings = {
          escape = null;
          y = "vim::HelixYank";
          d = "vim::HelixDelete";
          ctrl-c = "vim::SwitchToHelixNormalMode";
          enter = "vim::HelixSelectNext";
        };
      }
      {
        context = "ProjectPanel && not_editing";
        bindings = {
          "space a" = "agent::ToggleFocus";
          "space g" = "git_panel::ToggleFocus";
          "space q" = "workspace::CloseActiveDock";
          ctrl-m = "terminal_panel::Toggle";
          ctrl-f = "workspace::ToggleZoom";
          ctrl-h = "workspace::ActivatePaneLeft";
          ctrl-j = "workspace::ActivatePaneDown";
          ctrl-k = "workspace::ActivatePaneUp";
          ctrl-l = "workspace::ActivatePaneRight";
        };
      }
      {
        context = "OutlinePanel && not_editing";
        bindings = {
          "space a" = "agent::ToggleFocus";
          "space g" = "git_panel::ToggleFocus";
          "space q" = "workspace::CloseActiveDock";
          ctrl-m = "terminal_panel::Toggle";
          ctrl-f = "workspace::ToggleZoom";
          ctrl-h = "workspace::ActivatePaneLeft";
          ctrl-j = "workspace::ActivatePaneDown";
          ctrl-k = "workspace::ActivatePaneUp";
          ctrl-l = "workspace::ActivatePaneRight";
        };
      }
      {
        context = "GitPanel && vim_mode == helix_normal";
        bindings = {
          "space g" = "git_panel::ToggleFocus";
          p = "git::Pull";
          shift-p = "git::Push";
        };
      }
      {
        context = "GitPanel && ChangesList && !GitBranchSelector";
        bindings = {
          space = "git::ToggleStaged";
          c = "git_panel::FocusEditor";
        };
      }
      {
        context = "CommitEditor > Editor";
        bindings = {
          enter = "git::Commit";
          p = null;
          shift-p = null;
          "space g" = null;
        };
      }
      {
        context = "BufferSearchBar";
        bindings = {
          escape = null;
          ctrl-c = "buffer_search::Dismiss";
        };
      }
      {
        context = "Terminal";
        bindings = {
          "space a" = "agent::ToggleFocus";
          "space g" = "git_panel::ToggleFocus";
          "space q" = "workspace::CloseActiveDock";
          ctrl-m = "terminal_panel::Toggle";
          ctrl-f = "workspace::ToggleZoom";
          ctrl-h = "workspace::ActivatePaneLeft";
          ctrl-j = "workspace::ActivatePaneDown";
          ctrl-k = "workspace::ActivatePaneUp";
          ctrl-l = "workspace::ActivatePaneRight";
        };
      }
    ];
  };
}
