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
    ]
    ++ (lib.optionals (config.networking.hostName == "wsl") [
      ## python
      conda
      jetbrains.pycharm-community-bin
    ]);
}
