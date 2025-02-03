{
  config,
  pkgs,
  ...
}: {
  programs.nix-ld.enable = true;
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

      neovim
      gnumake
      gcc
      lua
      fzf
      python3
      python312Packages.pynvim
      nodejs_23
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
      light
      file
      shfmt
      shellcheck
      jq
      nodePackages.prettier
    ]
    ++ (lib.optionals (config.networking.hostName == "wsl") [
      ## python
      conda
      jetbrains.pycharm-community-bin
    ]);
}
