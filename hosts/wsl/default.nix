{
  lib,
  pkgs,
  ...
}: {
  wsl.enable = true;
  wsl.defaultUser = "nixos";

  system.build.installBootLoader = lib.mkForce "${pkgs.coreutils}/bin/true";

  myConfig = {
    username = "nixos";
  };

  system.stateVersion = "24.05";
}
