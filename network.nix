{ config, lib, modulesPath, options, pkgs, specialArgs }:

{
  # Enable networking through systemd-networkd; don't use the built-in NixOS modules.
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;
  networking.useNetworkd = false;
  systemd.network.enable = true;

  # Turn on verbose logging for systemd-networkd.
  systemd.services.systemd-networkd.serviceConfig.Environment = "SYSTEMD_LOG_LEVEL=debug";

  # Use DHCP to configure ether-type devices.
  systemd.network.networks = {
    "ether" = {
      matchConfig.Type = "ether";
      networkConfig.DHCP = "yes";
    };
  };
}
