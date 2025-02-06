{
  config,
  lib,
  pkgs,
  ...
}
:
with lib; {
  options = {
    useGUI = mkEnableOption "useGUI";
  };

  config = let
    cfg = config.myConfig;
  in
    mkIf config.useGUI {
      services.xserver = {
        enable = true;
      };

      services.displayManager = {
        enable = true;
        sddm = {
          enable = true;
          enableHidpi = true;
          theme = "sddm-astronaut-theme";
          package = mkForce pkgs.kdePackages.sddm;
        };
      };

      services.desktopManager.plasma6.enable = true;

      services.v2raya.enable = true;

      hardware.bluetooth.enable = true;

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
        (sddm-astronaut.override {embeddedTheme = "hyprland_kath";})
        kdePackages.qtmultimedia
        firefox

        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        nerd-fonts.fira-code
        nerd-fonts.symbols-only
        twitter-color-emoji

        wl-clipboard
        wl-clipboard-x11
        kitty
        nvtopPackages.full
      ];

      home-manager.users.${cfg.username}.xresources.properties = {
        "Xft.dpi" = 96;
      };
    };
}
