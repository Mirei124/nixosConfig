{lib, ...}: let
  inherit (lib) mkEnableOption mkOption types;
in {
  options.myConfig = {
    username = mkOption {
      type = types.str;
      default = "admin";
    };
  };

  options.useGUI = mkEnableOption "useGUI";
}
