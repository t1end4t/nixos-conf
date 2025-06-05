{ betterfox, ... }:
{
  # source: https://github.com/yokoffing/Betterfox
  home.file.".mozilla/firefox/default/user.js" = {
    source = "${betterfox}/user.js";
    # recursive = true;
  };

  # ublock setup: https://github.com/yokoffing/filterlists

  # pawall extension: https://github.com/bpc-clone/bypass-paywalls-firefox-clean
  # download path: https://gitflic.ru/project/magnolia1234/bpc_uploads

  # zlib extension: https://www.reddit.com/r/zlibrary/wiki/index/access/
}
