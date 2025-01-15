{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "https://mirrors.ustc.edu.cn/nix-channels/nixos-unstable/nixexprs.tar.xz";
    flake-parts.url = "github:hercules-ci/flake-parts";
    lite-config.url = "github:yelite/lite-config";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} (
      {
        inputs,
        lib,
        ...
      }: {
        imports = [
          inputs.lite-config.flakeModule
        ];

        lite-config = {
          nixpkgs = {
            config = {
              allowUnfree = true;
            };
            overlays = [];
          };

          systemModules = [
            {
              nix.settings.substituters = lib.mkBefore [
                "https://mirror.sjtu.edu.cn/nix-channels/store"
                "https://mirrors.ustc.edu.cn/nix-channels/store"
              ];
            }
            ./system
          ];
          homeModules = [./home];
          hostModuleDir = ./hosts;

          hosts = {
            "virt" = {
              system = "x86_64-linux";
              hostModule = {
                imports = [./hosts/virt];
                useGUI = lib.mkForce true;
              };
            };
            "wsl" = {
              system = "x86_64-linux";
              hostModule = {
                imports = [
                  inputs.nixos-wsl.nixosModules.default
                  ./hosts/wsl
                ];
              };
            };
          };

          homeConfigurations = {};
        };

        perSystem = {pkgs, ...}: {
          formatter = pkgs.alejandra;
        };
      }
    );
}
