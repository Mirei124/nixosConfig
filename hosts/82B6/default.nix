{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  useGUI = true;
  myConfig = {
    username = "k";
  };

  services.xserver.videoDrivers = ["nvidia" "amdgpu"];
  hardware.nvidia = {
    nvidiaSettings = false;
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:6:0:0";
    };
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [lenovo-legion-module cpupower];
  boot.kernelParams = ["nvidia.NVreg_DynamicPowerManagement=0x01"];
  environment.systemPackages = with pkgs; [lenovo-legion];
}
