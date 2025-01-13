{
  config,
  lib,
  ...
}: {
  imports = [
    ../options.nix
    ./home-manager.nix
    ./nixos.nix
    ./pkgs.nix
    ./services.nix
    ./gui.nix
  ];
}
