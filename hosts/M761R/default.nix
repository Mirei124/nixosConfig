{pkgs, ...}: {
  imports = [];

  programs.tmux.extraConfig = ''
    set -g mouse on
    set -g history-limit 1000000

    # copy select text, and don't jump to end
    # https://stackoverflow.com/questions/32374907/tmux-mouse-copy-mode-jumps-to-bottom
    bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-selection
  '';

  # programs.zsh.enableGlobalCompInit = false;
  # programs.zsh.enableBashCompletion = false;

  documentation.enable = false;
  system.tools.darwin-uninstaller.enable = false;

  system.stateVersion = 7;
}
