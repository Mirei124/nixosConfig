{
  description = "NixOS configuration";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs?rev=5ae3b07d8d6527c42f17c876e404993199144b6a";
    nixpkgs.url = "https://mirror.nju.edu.cn/nix-channels/nixos-unstable/nixexprs.tar.xz";

    flake-parts.url = "github:hercules-ci/flake-parts";
    lite-config.url = "github:yelite/lite-config";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
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
              problems.handlers = {
              };
            };
            overlays = [];
          };

          systemModules = [
            {
              nix.settings.substituters = lib.mkBefore [
                # "https://mirrors.osa.moe/nix-channels/store"
                "https://mirror.nju.edu.cn/nix-channels/store"
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
            "82B6" = {
              system = "x86_64-linux";
              hostModule = {
                imports = [./hosts/82B6];
              };
            };
            "connordeMacBook-Air" = {
              system = "aarch64-darwin";
              hostModule = {
                imports = [./hosts/Q4NMY];
              };
            };
            "M761R9JRQY" = {
              system = "aarch64-darwin";
              hostModule = {
                imports = [./hosts/M761R];
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
