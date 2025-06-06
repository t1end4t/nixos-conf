{ pkgs, ... }:

{
  home.packages = with pkgs; [
    unstable.code-cursor
    unstable.windsurf
  ];
}
