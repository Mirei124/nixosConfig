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
    desktopType = mkOption {
      type = types.enum ["none" "gnome" "plasma"];
      default = "gnome";
      description = "The desktop manager to use.";
    };
  };

  config = let
    cfg = config.myConfig;
  in
    mkIf config.useGUI (mkMerge [
      (mkIf (config.desktopType == "gnome") {
        services.displayManager.gdm.enable = true;
        services.desktopManager.gnome.enable = true;

        environment.systemPackages = with pkgs; [
          gnomeExtensions.appindicator
          gnomeExtensions.kimpanel
        ];
      })

      (mkIf (config.desktopType == "plasma") {
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

        environment.systemPackages = with pkgs; [
          (sddm-astronaut.override {embeddedTheme = "hyprland_kath";})
          kdePackages.qtmultimedia
        ];
      })

      {
        services.v2raya.enable = true;
        services.udev.extraRules = ''
          ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils.outPath}/bin/chgrp video $sys$devpath/brightness", RUN+="${pkgs.coreutils.outPath}/bin/chmod g+w $sys$devpath/brightness"
        '';

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

        home-manager.users.${cfg.username}.xresources.properties = {
          "Xft.dpi" = 96;
        };
      }
    ]);
}
