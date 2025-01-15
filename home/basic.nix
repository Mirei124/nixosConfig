{...}: {
  home.language.base = "zh_CN.UTF-8";

  programs.git = {
    enable = true;
    userName = "Connor";
    userEmail = "connor@noreply.com";
    aliases = {
      "lg" = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
    extraConfig = {
      safe.directory = "/etc/nixos";
    };
  };

  xdg.configFile = {
    "nvim" = {
      source = ../configFiles/nvimConfig;
      recursive = true;
    };
  };
}
