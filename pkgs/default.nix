# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs }:
{
  chatgpt = import ./chatgpt.nix { inherit pkgs; };
  claude-desktop = import ./claude-desktop.nix { inherit pkgs; };
}
