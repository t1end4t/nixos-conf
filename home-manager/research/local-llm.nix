{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nvtopPackages.nvidia # monitoring hardware

    # unstable.ollama-cuda # for codex
  ];
}
