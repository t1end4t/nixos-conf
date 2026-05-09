{
  lib,
  pkgs,
  ...
}:
let
  skillPython = pkgs.python313.withPackages (
    ps:
    with ps;
    [
      biopython
      dask
      defusedxml
      h5py
      lxml
      matplotlib
      numpy
      openai
      openpyxl
      pandas
      pdf2image
      pdfplumber
      pillow
      # pypdf
      python-docx
      python-dotenv
      python-pptx
      pyyaml
      requests
      scikit-learn
      scipy
      seaborn
      statsmodels
      validators
    ]
    ++ lib.optionals (ps ? anthropic) [ anthropic ]
    ++ lib.optionals (ps ? lightning) [ lightning ]
    ++ lib.optionals (ps ? markitdown) [ markitdown ]
    ++ lib.optionals (ps ? mcp) [ mcp ]
    ++ lib.optionals (ps ? polars) [ polars ]
    # ++ lib.optionals (ps ? pypdf2) [ pypdf2 ]
    ++ lib.optionals (ps ? scholarly) [ scholarly ]
    ++ lib.optionals (ps ? torch) [ torch ]
  );
in
{
  home.packages = with pkgs; [
    ############ claude-code ############
    # curl -fsSL https://claude.ai/install.sh | bash
    # curl -fsSL https://opencode.ai/install | bash
    # npm install -g @anthropic-ai/sandbox-runtime

    ############ router ############
    # npm set prefix ~/.npm-global
    # npm install -g 9router
    nodejs

    # uvx --from git+https://github.com/oraios/serena serena
    # skillPython
    python313Packages.python
    uv

    # other packages
    bun

    ############ codex skill runtimes ############
    # libreoffice-qt
    # pandoc
    # tectonic
    # imagemagick
    # ]
    # ++ lib.optionals (pkgs.nodePackages ? pptxgenjs) [
    #   pkgs.nodePackages.pptxgenjs
    # ]
    # ++ lib.optionals (pkgs.nodePackages ? docx) [
    #   pkgs.nodePackages.docx
  ];

  # remember login
  services.gnome-keyring.enable = true;
}
