{ pkgs, ... }:

{
  home.packages = with pkgs; [
    playwright-driver.browsers # for using aider
  ];
}
