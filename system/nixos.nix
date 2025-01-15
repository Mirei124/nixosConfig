{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.myConfig;
in {
  imports = [];

  boot.readOnlyNixStore = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager = {
    enable = true;
    plugins = lib.mkForce [];
  };
  networking.firewall.enable = false;

  time.timeZone = "Asia/Shanghai";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
  };

  programs.zsh.enable = true;
  users.users.${cfg.username} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    uid = 1000;
    group = "${cfg.username}";
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHnCWMO5GnDQWnLCMccj8Pmwonh4vO3JMeCmXhmAK4lNnv6zy5/SFTCL5Ng2ghs6DsnO+6ZhzVihU3usxkZHj6iIuGLv36ssXLyMnoMjivhoRHlgY5a2ysFJKOBPYQhfHQhvv4syJSDQfEF2PJeWiBuW67F2OLjFC2h/4ttuP0fBduv5JAi0ccVmx6io0r4j98+kKP7S84TpfWZypAi6DhjvbBJ1DJvFOxYDrHjUJsgkN/RmX2QiH9+Wx0v7ZDAOFGlcQxj/bnQhwdUoOWggQ3ZW1j767CcDiVEsyvGQbI/er217pWKJTG1GNA+fWzgK8ZaMt7KWGaYd9Jcg9HMkTCEWKRLD1jWMZeUdOiAdk3QfiAOC21sFULkNaPJTfD6T+sGIWBLDlqfSp36wyrsEpKC6G7uQvPF8abICWyJncXeaHs1+mi5Rflr4T+RUq9nbxd0hauc122xFxDxAShtOTnI2vW78QS8U70hQcFe+L7I+2IfVJdA9/EGskhRBWKeRE= k"
    ];
  };
  users.groups = {
    ${cfg.username} = {gid = 1000;};
  };

  environment.shellAliases = {
    "vi" = "nvim";
    "nbs" = "sudo /etc/nixos/update-permission-and-format.sh; sudo nixos-rebuild switch --flake '/etc/nixos?submodules=1'";
    "ndb" = "nix repl -f '<nixpkgs>'";
    "npk" = "sudo -E nvim /etc/nixos/system/pkgs.nix";
  };
  environment.variables = {
    EDITOR = "nvim";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 5d";
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = ["root" "@wheel"];
  };

  system.stateVersion = lib.mkDefault "24.11";
}
