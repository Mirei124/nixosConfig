{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs;
    []
    ++ lib.optionals (config.networking.hostName == "connordeMacBook-Air")
    ([
        alejandra
        btop
        coreutils
        gdu
        git
        inxi
        iproute2mac
        neovim
        nix-search
        nmap
        nodejs
        pnpm
        uv
        qbittorrent-enhanced
        stats
        obsidian
        # utm
        miniserve
        mpv
        lf
        tmux
        yt-dlp
        aria2
        htop
        android-tools
        jujutsu
        typst
        prettier
        nix-tree
        tree-sitter
        rsync
        imagemagick
        poppler-utils
        wget
        battery-toolkit
        drawio
        opencode
        maccy
        tealdeer

        nvtopPackages.apple
      ]
      ++ (with pkgs.darwin; [
        lsusb
      ]))
    ++ lib.optionals (config.networking.hostName == "M761R9JRQY") [
      alejandra
      neovim
      kitty
      cmux
    ];

  environment.shellAliases = {
    "nbs" = "sudo darwin-rebuild switch --flake /etc/nix-darwin";
    "npk" = "sudo -E nvim /etc/nix-darwin/system/darwin.nix";
  };

  services.openssh = {
    enable = true;
    extraConfig = ''
      PermitRootLogin no
      PasswordAuthentication no
      KbdInteractiveAuthentication no
    '';
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 5d";
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
