{
  config,
  lib,
  pkgs,
  ...
}
:
lib.mkIf config.useGUI (let
  cfg = config.myConfig;
in {
  services.xserver = {
    enable = true;
  };

  services.displayManager = {
    enable = true;
    sddm = {
      enable = true;
      enableHidpi = true;
      theme = "catppuccin-mocha";
      package = lib.mkForce pkgs.kdePackages.sddm;
    };
  };

  services.desktopManager.plasma6.enable = true;

  programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [
      wcm
      wf-shell
    ];
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-pinyin-zhwiki
        fcitx5-pinyin-moegirl
        fcitx5-anthy # 日本語
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    catppuccin-sddm
    firefox
  ];

  home-manager.users.${cfg.username}.xresources.properties = {
    "Xft.dpi" = 96;
  };
})
