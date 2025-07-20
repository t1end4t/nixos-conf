{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # unstable.aider-chat-with-playwright # best programming tools
    aider-chat-with-playwright # best programming tools
    playwright-driver.browsers # for using aider
    playwright
  ];
}
