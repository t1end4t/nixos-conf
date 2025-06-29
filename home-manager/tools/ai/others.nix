{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # unstable.aichat # cli LLM
    nodejs # to install gemini
    python311Packages.pipx
  ];

  # try to run: npm set prefix ~/.npm-global
  # npm install -g @google/gemini-cli
}
