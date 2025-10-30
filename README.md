# My own NixOS config

# NOTE:

1. Command to prevent Github limit

```nu
env NIX_CONFIG="access-tokens = github.com=ghp_my_own_token_here" nix flake update
```

```nu
$env.GITHUB_TOKEN = "ghp_my_own_token_here"
```
