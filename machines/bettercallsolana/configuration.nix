{ config, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

  networking = {
    useDHCP = false;
    interfaces.ens3 = {
      ipv4.addresses = [{
        address = "109.206.243.227";
        prefixLength = 32;
      }];
      ipv4.routes = [{
        address = "172.0.0.1";
        prefixLength = 32;
        options = { scope = "link"; };
      }];
    };
    defaultGateway = {
      address = "172.0.0.1";
      interface = "ens3";
    };
    nameservers = [ "8.8.8.8" "1.1.1.1" ];
  };

  services.qemuGuest.enable = true;

  synced.caddy-secret-file = "${config.synced.configDir}/caddy/bettercallsolana.env";

  users.users.root = {
    openssh.authorizedKeys.keys = (import ../../ssh-keys.nix).admin;
  };
}