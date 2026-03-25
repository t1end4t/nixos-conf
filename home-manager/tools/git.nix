{
  programs.git = {
    enable = true;
    settings.user = {
      name = "t1end4t";
      email = "tiendatarse3004@gmail.com";

      # git pull apply for submodule
      submodule.recurse = true;
    };
    lfs.enable = true;

  };
}
