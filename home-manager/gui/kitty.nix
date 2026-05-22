{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;

    font = {
      name = "Lilex Nerd Font Propo";
      size = 12;
    };

    settings = {
      shell = "${pkgs.nushell}/bin/nu";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      window_padding_width = 6;
      background_opacity = "0.95";

      # Inline graphics protocol is enabled by default in kitty.
      # Keep remote-control socket off unless explicitly needed.
      allow_remote_control = false;
    };
  };
}
