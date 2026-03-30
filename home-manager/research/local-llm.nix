{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (unstable.llama-cpp.override { cudaSupport = true; })
    nvtop # monitoring hardware
  ];
}
