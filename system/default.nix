{
  config,
  hostPlatform,
  lib,
  ...
}: {
  imports =
    [
      ../options.nix
    ]
    ++ lib.optionals hostPlatform.isLinux [
      ./home-manager.nix
      ./nixos.nix
      ./pkgs.nix
      ./services.nix
      ./gui.nix
    ]
    ++ lib.optionals hostPlatform.isDarwin [
      ./darwin.nix
    ];
}
