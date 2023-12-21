{ config, lib, modulesPath, options, pkgs, specialArgs }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.availableKernelModules = [
    "virtio_pci"
    "xhci_pci"
    "usbhid"
    "usb_storage"
  ];

  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  boot.swraid.enable = false;

  boot.initrd.systemd = {
    enable = true;
    emergencyAccess = true;
    managerEnvironment = {
      SYSTEMD_LOG_LEVEL = "debug";
    };
  };

  # We're in Tacoma, WA, USA.
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/540f441f-24fe-4748-b9e6-eb2e3e6d79ea";
      fsType = "ext4";
    };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/09E3-8BEE";
      fsType = "vfat";
    };

  swapDevices = [
    { device = "/dev/disk/by-uuid/2ad09cb9-232d-448a-98c3-45797f0208d1"; }
  ];

}
