{ pkgs, ... }:
let
  ROOT = builtins.toString ./.;
in
{
  imports = [
    ./betterfox.nix
  ];

  # Source: https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
  programs.firefox = {
    enable = true;
    package = (
      pkgs.wrapFirefox (pkgs.firefox-unwrapped.override {
        pipewireSupport = true;
      }) { }
    );

    profiles = {
      default = {
        id = 0;
        path = "default";
        # source: https://github.com/Jamir-boop/minimalisticfox
        userChrome = builtins.readFile "${ROOT}/userChrome.css";
        userContent = builtins.readFile "${ROOT}/userContent.css";
      };
    };

    # source: about:policies#documentation
    policies = {
      AppAutoUpdate = true;
      DisableAppUpdate = false;
      DisplayBookmarksToolbar = "never";
      DisablePrivateBrowsing = true;
      DisplayMenuBar = "default-off";
      SearchBar = "unified";
      Preferences = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        # "browser.display.use_document_fonts" = 0; # not default
        "browser.fullscreen.autohide" = false;
        "browser.startup.page" = 3;
        "font.name.monospace.x-western" = "IntoneMono Nerd Font Propo";
        "browser.compactmode.show" = true;
        "browser.startup.homepage" = "https://duckduckgo.com";
      };

      # source: about:support
      ExtensionSettings = (import ./extensions.nix);

      # source: https://github.com/mozilla/policy-templates/blob/master/docs/index.md#websitefilter
      WebsiteFilter = (import ./filter.nix);
    };
  };
}
