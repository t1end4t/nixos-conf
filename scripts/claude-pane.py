import json
import os
from pathlib import Path
import re
import shlex
import subprocess
import sys
import time


def summary(name, data):
    for key in ("file_path", "path", "command", "pattern", "url", "query", "description", "prompt"):
        if value := data.get(key):
            value = " ".join(str(value).split())
            return f"[{name}] {value[:117] + '...' if len(value) > 120 else value}"
    return f"[{name}]"


def show(record):
    message = record.get("message", {})
    if record.get("type") not in ("assistant", "user"):
        return
    content = message.get("content", [])
    if isinstance(content, str):
        content = [{"type": "text", "text": content}]
    for block in content:
        if block.get("type") == "text":
            text = block.get("text", "")
        elif block.get("type") == "tool_use":
            data = block.get("input", {})
            text = summary(block.get("name", "tool"), data if isinstance(data, dict) else {})
        elif block.get("type") == "tool_result" and block.get("is_error"):
            text = "[tool failed; details in Claude transcript]"
        else:
            continue
        print(re.sub(r"[\x00-\x08\x0b-\x1f\x7f]", "", text), flush=True)


def watch(transcript, done, owner):
    position = 0
    stopped_at = None
    while True:
        if transcript.exists():
            with transcript.open() as stream:
                stream.seek(position)
                while line := stream.readline():
                    if not line.endswith("\n"):
                        break
                    position = stream.tell()
                    show(json.loads(line))
        if done.exists() or (done.parent / "session.done").exists() or not Path(f"/proc/{owner}").exists():
            if stopped_at is None:
                stopped_at = time.monotonic()
            if time.monotonic() - stopped_at >= 2:
                print("[subagent finished]", flush=True)
                return
        time.sleep(0.2)


def hook(event):
    session = event["session_id"]
    agent = event.get("agent_id", "")
    if not re.fullmatch(r"[A-Za-z0-9_-]+", session) or (
        agent and not re.fullmatch(r"[A-Za-z0-9_-]+", agent)
    ):
        raise ValueError("invalid session_id or agent_id")
    state = Path(os.environ.get("XDG_RUNTIME_DIR", Path.home() / ".local/state")) / "claude-panes" / session
    state.mkdir(mode=0o700, parents=True, exist_ok=True)
    kind = event["hook_event_name"]
    if kind == "SessionEnd":
        (state / "session.done").write_text("finished\n")
        return
    if not agent:
        raise ValueError("missing agent_id")
    done = state / f"{agent}.done"
    if kind == "SubagentStop":
        done.write_text("finished\n")
        return
    if kind != "SubagentStart":
        raise ValueError(f"unsupported hook: {kind}")
    done.unlink(missing_ok=True)
    (state / "session.done").unlink(missing_ok=True)
    transcript = Path(event["transcript_path"]).expanduser().with_suffix("") / "subagents" / f"agent-{agent}.jsonl"
    owner = os.getppid()
    while owner > 1:
        status = Path(f"/proc/{owner}/status").read_text()
        parent = int(re.search(r"^PPid:\s+(\d+)", status, re.MULTILINE)[1])
        if Path(f"/proc/{owner}/comm").read_text().strip() in ("claude", "node"):
            break
        owner = parent
    if owner <= 1:
        raise RuntimeError("Claude parent process not found")
    command = shlex.join([sys.executable, str(Path(__file__).resolve()), "watch", str(transcript), str(done), str(owner)])
    subprocess.run(["codex-run", f"claude-{session}-{agent}-{time.time_ns()}", command], cwd=event["cwd"], check=True, stdout=subprocess.DEVNULL)


if __name__ == "__main__":
    try:
        if len(sys.argv) == 5 and sys.argv[1] == "watch":
            watch(Path(sys.argv[2]), Path(sys.argv[3]), int(sys.argv[4]))
        else:
            hook(json.load(sys.stdin))
    except (KeyError, ValueError, OSError, RuntimeError, subprocess.CalledProcessError) as error:
        print(f"claude-pane: {error}", file=sys.stderr)
        sys.exit(1)
