{ pkgs, ... }:

{
  home.packages = with pkgs; [
    unstable.jan # GUI for chatgpt, claude, etc.
  ];
}
