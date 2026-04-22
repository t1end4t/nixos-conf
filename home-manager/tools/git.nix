{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "t1end4t";
        email = "tiendatarse3004@gmail.com";
      };
      submodule.recurse = true;
      credential.helper = "!gh auth git-credential";
    };
    lfs.enable = true;
  };
}
