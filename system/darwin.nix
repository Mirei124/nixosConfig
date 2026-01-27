{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
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
  ];
}
