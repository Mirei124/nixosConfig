{pkgs, ...}: {
  imports = [];

  programs.zsh.enableGlobalCompInit = false;
  programs.zsh.enableBashCompletion = false;

  documentation.enable = false;
  system.tools.darwin-uninstaller.enable = false;

  system.stateVersion = 7;
}
