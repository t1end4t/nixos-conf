{pkgs}: let
  pname = "orca";
  version = "1.4.227";
  src = pkgs.fetchurl {
    url = "https://github.com/stablyai/orca/releases/download/v${version}/orca-linux.AppImage";
    hash = "sha256-Mgrfi8p01AhqMyU5OlknWw82kEbvZCKdLAa/DBcxW4w=";
  };
  contents = pkgs.appimageTools.extractType2 {inherit pname version src;};
in
  pkgs.appimageTools.wrapType2 {
    inherit pname version src;
    nativeBuildInputs = [pkgs.makeWrapper];

    extraInstallCommands = ''
      install -Dm444 ${contents}/orca-ide.desktop $out/share/applications/orca-ide.desktop
      substituteInPlace $out/share/applications/orca-ide.desktop \
        --replace-fail 'Exec=AppRun' "Exec=$out/bin/orca"
      cp -r ${contents}/usr/share/icons $out/share/
      wrapProgram $out/bin/orca \
        --add-flags "\''${WAYLAND_DISPLAY:+--ozone-platform=wayland}" \
        --add-flags '--password-store=gnome-libsecret'
    '';

    meta = {
      description = "IDE for running parallel coding agents";
      homepage = "https://github.com/stablyai/orca";
      license = pkgs.lib.licenses.mit;
      mainProgram = "orca";
      platforms = ["x86_64-linux"];
      sourceProvenance = [pkgs.lib.sourceTypes.binaryNativeCode];
    };
  }
