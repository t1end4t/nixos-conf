{ pkgs, ... }:

let
  mod = "$mod";
  lock_after = 300;
  off_after = 10;
  lock_cmd = "${pkgs.swaylock-effects}/bin/swaylock --clock --indicator";
in
''
  ################
  # CURSOR HIDE
  ################
  cursor_inactive_timeout = 3
''
