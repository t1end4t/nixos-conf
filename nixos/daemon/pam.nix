{ ... }:
{
  # source: https://nixos.wiki/wiki/Sway#Swaylock_cannot_be_unlocked_with_the_correct_password
  # enable PAM for swaylock
  security.pam.services.swaylock = { };
}
