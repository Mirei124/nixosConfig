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
        # battery-toolkit
        drawio
        opencode
        maccy
        tealdeer
        cc-switch
        claude-code

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
      maccy
      tmux
      ffmpeg
      prettier
      uv
      tokei
      coreutils
      jujutsu
      ripgrep
      fd
      lf
      tree-sitter
      trash-cli
      gnused
    ];

  environment.shellAliases = {
    "nbs" = "sudo darwin-rebuild switch --flake /etc/nix-darwin";
    "npk" = "sudo -E nvim /etc/nix-darwin/system/darwin.nix";
  };

  services.openssh = lib.mkMerge [
    (lib.mkIf (config.networking.hostName != "M761R9JRQY") {
      enable = true;
    })
    {
      extraConfig = ''
        PermitRootLogin no
        PasswordAuthentication no
        KbdInteractiveAuthentication no
      '';
    }
  ];

  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g mouse on
      set -g history-limit 1000000
      set -g mode-keys vi

      # copy select text, and don't jump to end
      # https://stackoverflow.com/questions/32374907/tmux-mouse-copy-mode-jumps-to-bottom
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-selection
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
