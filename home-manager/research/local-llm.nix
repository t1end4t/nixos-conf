{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (unstable.llama-cpp.override { cudaSupport = true; })
    nvtopPackages.nvidia # monitoring hardware
  ];
}
