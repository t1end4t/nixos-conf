{ betterfox, ... }:
let
  firefoxOverrides = ''

    /** LOCAL OVERRIDES ***/
    user_pref("browser.ml.enable", true);
    user_pref("browser.ml.chat.enabled", true);
    user_pref("browser.ml.chat.shortcuts", true);
    user_pref("browser.ml.chat.shortcuts.custom", true);
    user_pref("browser.ml.chat.sidebar", true);
  '';
in
{
  # source: https://github.com/yokoffing/Betterfox
  programs.firefox.profiles.default.extraConfig = (builtins.readFile "${betterfox}/user.js") + firefoxOverrides;

  # ublock setup: https://github.com/yokoffing/filterlists

  # pawall extension: https://github.com/bpc-clone/bypass-paywalls-firefox-clean
  # download path: https://gitflic.ru/project/magnolia1234/bpc_uploads

  # zlib extension: https://www.reddit.com/r/zlibrary/wiki/index/access/
  # path: https://go-to-library.sk/#browser_extensions_tab
}
