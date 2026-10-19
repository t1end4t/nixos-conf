# Scripts Index

## Files
- `init.sh` — machine setup.
- `gpg-files.sh` — encrypt configured files.
- `remove-gpg-files.sh` — remove encrypted generated files.
- `codex-run.sh` — visible background jobs: tmux shown in an Orca or Zellij right column; successful viewers close automatically, failed jobs stay visible, and tmux retains logs.
- `claude-pane.py` — Claude subagent hooks; show readable subagent messages and short tool labels, without raw tool results.
- `test-codex-run.sh` — check job output, exit status, environment, split selection, and duplicate protection.
- `setup-agent-panes.py` — merge Claude pane hooks and shared agent instructions without replacing existing settings.
