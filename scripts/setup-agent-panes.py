import json
from pathlib import Path
import sys


command = sys.argv[1]
home = Path.home()
settings_path = home / ".claude/settings.json"
settings_path.parent.mkdir(parents=True, exist_ok=True)
settings = json.loads(settings_path.read_text()) if settings_path.exists() else {}
hooks = settings.setdefault("hooks", {})
for event in ("SubagentStart", "SubagentStop", "SessionEnd"):
    entries = hooks.setdefault(event, [])
    for entry in entries:
        entry["hooks"] = [hook for hook in entry.get("hooks", []) if "claude-pane.py" not in hook.get("command", "")]
    entries[:] = [entry for entry in entries if entry.get("hooks")]
    entries.append({"hooks": [{"type": "command", "command": command, "timeout": 20}]})
backup = settings_path.with_name("settings.json.before-agent-panes")
if settings_path.exists() and not backup.exists():
    backup.write_bytes(settings_path.read_bytes())
    backup.chmod(0o600)
temporary = settings_path.with_name("settings.json.agent-panes.tmp")
temporary.touch(mode=0o600)
temporary.write_text(json.dumps(settings, indent=2) + "\n")
temporary.replace(settings_path)

instructions = """## Visible Background Commands

- Run long shell commands with `codex-run UNIQUE_NAME 'COMMAND'`. Use a unique alphanumeric, underscore, or hyphen name. The launcher keeps the working directory and opens a tmux viewer inside Orca or the current Zellij session.
- Keep the main agent on the left. The first job opens a right column; later jobs stack below the previous viewer. Do not create extra columns or nest Zellij.
- Keep quick inspections in the normal command tool. If the launcher fails, report the error; do not silently fall back to hidden execution.
- Read output with `tmux -L codex capture-pane -pJ -S -200 -t '=NAME:'`. Check completion with `tmux -L codex display -p -t '=NAME:' '#{pane_dead} #{pane_dead_status}'`: `1 0` means success; `0` means running. Launcher success does not mean job success.
- Completed panes remain visible. Closing a viewer does not stop its job. Do not kill sessions or send input to existing user panes without permission.
- Claude subagent hooks automatically open read-only transcript panes. Do not launch another worker just to display the same subagent.
"""
for relative in (".codex/AGENTS.md", ".claude/CLAUDE.md"):
    path = home / relative
    path.parent.mkdir(parents=True, exist_ok=True)
    text = path.read_text() if path.exists() else ""
    if "## Visible Background Commands" not in text:
        path.write_text(text.rstrip() + "\n\n" + instructions)
print("Agent panes configured for Codex and Claude.")
