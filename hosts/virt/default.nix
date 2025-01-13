{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  useGUI = false;
  myConfig = {
    username = "k";
  };
}
