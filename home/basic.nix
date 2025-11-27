{...}: {
  home.language.base = "zh_CN.UTF-8";

  programs.git = {
    enable = true;
    settings = {
      aliases = {
        "lg" = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
      user.email = "connor@noreply.com";
      user.name = "Connor";
      safe.directory = "/etc/nixos";
    };
  };

  xdg.configFile = {
    "nvim" = {
      source = ../configFiles/nvimConfig;
      recursive = true;
    };
    "fontconfig" = {
      source = ../configFiles/config/fontconfig;
      recursive = true;
    };
  };
}
