{
  config,
  pkgs,
  ...
}: {
  programs.nix-ld.enable = true;
  programs.firefox = {
    enable = true;
    languagePacks = ["en-US" "zh-CN"];
  };
  environment.systemPackages = with pkgs;
    [
      zsh
      git
      wget
      curl

      alejandra
      nix-search-cli
      nix-tree
      nh
      nix-ld

      neovim
      gnumake
      gcc
      lua
      fzf
      python3
      python312Packages.pynvim
      nodejs_24
      unzip
      gnutar
      tree-sitter

      # cargo
      tree
      htop
      fd
      ripgrep
      gdu
      lf
      tldr
      tmux
      file
      shfmt
      shellcheck
      jq
      nodePackages.prettier
      sshfs
      wl-clipboard
      wl-clipboard-x11
      openssl
    ]
    ++ (lib.optionals (config.useGUI) [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
      twitter-color-emoji

      # nvtopPackages.full
      light
      (pkgs.callPackage ../packages/wfhelper.nix {})

      kitty
      dconf-editor
      telegram-desktop
      pavucontrol
      freerdp
      moonlight-qt
    ])
    ++ (
      lib.optionals (config.networking.hostName == "wsl") [
        ## python
        # conda
        # jetbrains.pycharm-community-bin
      ]
    );
}
