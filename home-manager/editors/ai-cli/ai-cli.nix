{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  home.packages = with pkgs; [
    unstable.aider-chat-with-playwright # will replace by hinty soon
  ];

  # remember login
  services.gnome-keyring.enable = true;

  # create symlink for secret aider and aider example
  home.file.".aider.conf.yml.gpg" = {
    source = "${ROOT}/secrets/aider.conf.yml.gpg";
  };
}
