{ config, lib, modulesPath, options, pkgs, specialArgs }:

{
  users.users.philip = {
    isNormalUser = true;
    description = "Philip Taron";
    extraGroups = [ "wheel" ];
  };
}
