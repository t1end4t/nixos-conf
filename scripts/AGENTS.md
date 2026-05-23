Use this guide when working under `scripts/`.

## Start Here
- Setup script: `init.sh`
- Secret file helpers: `gpg-files.sh`, `remove-gpg-files.sh`

## Constraints
- Treat scripts as user-machine operations; avoid destructive behavior without explicit confirmation.
- Preserve shell portability style already used in each script.
- Verify with `shellcheck` if available, otherwise run the smallest safe command path.
