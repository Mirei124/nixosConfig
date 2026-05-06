{pkgs, ...}: {
  environment.systemPackages = with pkgs;
    [
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
      uv
      qbittorrent-enhanced
      stats
      obsidian
      utm
      miniserve
      mpv
      pnpm
      nvtopPackages.apple
      lf
      tmux
      yt-dlp
      aria2
      htop
      android-tools
      jujutsu
      typst
      prettier
    ]
    ++ (with pkgs.darwin; [
      lsusb
    ]);

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
