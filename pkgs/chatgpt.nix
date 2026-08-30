{ pkgs }:
let
  inherit (pkgs) lib;

  runtimeLibraries = with pkgs; [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    gdk-pixbuf
    glib
    graphite2
    gtk3
    libdrm
    libgbm
    libglvnd
    libnotify
    libsecret
    libusb1
    libx11
    libxcb
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxkbcommon
    libxrandr
    nspr
    nss
    openssl
    pango
    stdenv.cc.cc.lib
    udev
    wayland
  ];

  unwrapped = pkgs.stdenvNoCC.mkDerivation {
    pname = "chatgpt-unwrapped";
    version = "26.825.31414";

    src = pkgs.fetchurl {
      url = "https://persistent.oaistatic.com/codex-app-prod/linux/deb/pool/main/c/chatgpt/chatgpt_26.825.31414_amd64.deb";
      hash = "sha256-wXMEi6gPevnNiQT5ofJyr/SUejFPb+l9obuDaEds3Pk=";
    };

    nativeBuildInputs = [ pkgs.dpkg ];

    dontConfigure = true;
    dontBuild = true;
    dontFixup = true;
    dontStrip = true;

    unpackPhase = ''
      runHook preUnpack
      dpkg-deb -x "$src" .
      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p "$out/lib" "$out/share"
      cp -a usr/lib/chatgpt "$out/lib/"
      cp -a usr/share/applications usr/share/pixmaps "$out/share/"
      tectonic="$out/lib/chatgpt/resources/plugins/openai-bundled/plugins/latex/bin/tectonic"
      rm "$tectonic"
      ln -s "${lib.getExe pkgs.tectonic-unwrapped}" "$tectonic"
      runHook postInstall
    '';
  };

  launcher = pkgs.writeShellScript "chatgpt-launcher" ''
    exec ${unwrapped}/lib/chatgpt/ChatGPT \
      ''${WAYLAND_DISPLAY:+--ozone-platform=wayland --enable-features=WaylandWindowDecorations --enable-wayland-ime=true} \
      "$@"
  '';
in
pkgs.buildFHSEnv {
  name = "chatgpt";
  targetPkgs =
    _:
    runtimeLibraries
    ++ (with pkgs; [
      git
      glib
      xdg-utils
    ]);
  runScript = launcher;

  extraInstallCommands = ''
    mkdir -p "$out/share"
    cp -a ${unwrapped}/share/applications "$out/share/"
    cp -a ${unwrapped}/share/pixmaps "$out/share/"
  '';

  passthru.unwrapped = unwrapped;

  meta = {
    description = "ChatGPT desktop application by OpenAI";
    homepage = "https://developers.openai.com/codex/app";
    license = lib.licenses.unfree;
    mainProgram = "chatgpt";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
