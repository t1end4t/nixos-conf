{ ... }:
{
  # source: https://nixos.wiki/wiki/Bootloader#Limiting_amount_of_entries_with_grub_or_systemd-boot
  # limit configurations in boot menu
  boot.loader.systemd-boot.configurationLimit = 5;
}
