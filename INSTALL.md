# Install

## 1. Apply Nix config

From this repo:

```bash
nh os switch
nh home switch
```

Or explicit host:

```bash
sudo nixos-rebuild switch --flake .#laptop
home-manager switch --flake .#tiendat@laptop
```

After Home Manager, open a new shell so `PATH` updates.

## 2. Set up workbase repos

Use `--recurse-submodules` because several repos contain submodules.

```bash
mkdir -p ~/nix-dev ~/codebases

ensure_repo() {
  local url="$1" dir="$2"
  if [ ! -d "$dir/.git" ]; then
    git clone --recurse-submodules "$url" "$dir"
  else
    echo "Repo exists: $dir. Pulling latest..."
    git -C "$dir" pull --recurse-submodules
  fi
}

# nix-dev
ensure_repo git@github.com:t1end4t/nixos-conf.git      ~/nix-dev/nixos-conf
ensure_repo git@github.com:t1end4t/nix-templates.git   ~/nix-dev/nix-templates

# home
ensure_repo git@github.com:t1end4t/second-brain.git    ~/second-brain

# codebases
ensure_repo git@github.com:t1end4t/research-lab.git    ~/codebases/research-lab
ensure_repo git@github.com:t1end4t/dev-sandbox.git     ~/codebases/dev-sandbox
ensure_repo git@github.com:t1end4t/company-stack.git   ~/codebases/company-stack
ensure_repo git@github.com:t1end4t/side-projects.git   ~/codebases/side-projects
```

Refresh submodules later:

```bash
for d in ~/nix-dev/nixos-conf ~/nix-dev/nix-templates ~/second-brain \
         ~/codebases/research-lab ~/codebases/dev-sandbox \
         ~/codebases/company-stack ~/codebases/side-projects; do
  [ -d "$d/.git" ] && git -C "$d" submodule update --init --recursive
done
```

## 3. Set up npm global prefix

`home-manager/ai-tools.nix` installs `nodejs`, not global npm tools.

```bash
npm set prefix ~/.npm-global
```

Make sure this is in `PATH`:

```bash
npm config get prefix
command -v npm
```

Expected prefix:

```text
/home/tiendat/.npm-global
```

If global bins are missing from `PATH`, add this to shell config:

```bash
export PATH="$HOME/.npm-global/bin:$PATH"
```

## 4. Install AI coding tools not managed by Nix

### Claude Code

```bash
if ! command -v claude >/dev/null 2>&1; then
  curl -fsSL https://claude.ai/install.sh | bash
else
  echo "Claude Code already installed: $(claude --version 2>/dev/null || echo ok)"
fi
```

### OpenAI Codex

```bash
if ! command -v codex >/dev/null 2>&1 || [ "$(npm info @openai/codex version 2>/dev/null)" != "$(npm list -g --depth=0 @openai/codex 2>/dev/null | grep @openai/codex | sed 's/.*@//')" ]; then
  npm install -g @openai/codex
else
  echo "Codex up-to-date"
fi
```

### OpenCode

```bash
if ! command -v opencode >/dev/null 2>&1; then
  curl -fsSL https://opencode.ai/install | bash
else
  echo "OpenCode already installed: $(opencode --version 2>/dev/null || echo ok)"
fi
```

### 9router

```bash
if ! command -v 9router >/dev/null 2>&1 || [ "$(npm info 9router version 2>/dev/null)" != "$(npm list -g --depth=0 9router 2>/dev/null | grep 9router | sed 's/.*@//')" ]; then
  npm install -g 9router
else
  echo "9router up-to-date"
fi
```

### Claude sandbox runtime

```bash
if ! npm list -g --depth=0 @anthropic-ai/sandbox-runtime >/dev/null 2>&1; then
  npm install -g @anthropic-ai/sandbox-runtime
else
  echo "Sandbox runtime up-to-date"
fi
```

### pi-coding-agent

TODO: add exact install command after verifying the official install source/package name.

Check after install:

```bash
command -v pi-coding-agent
pi-coding-agent --version
```

## 5. Smoke test

```bash
for cmd in node npm bun uv python claude codex opencode 9router; do
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "OK: $cmd"
  else
    echo "MISSING: $cmd"
  fi
done
```

If anything is missing, check whether it is installed by Nix/Home Manager or by npm/curl above.
