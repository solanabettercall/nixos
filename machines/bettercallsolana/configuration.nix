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
    initialHashedPassword = "";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCu0ibcTXkcosUdMfW+rX8zmtz3Q52lf1PVBQ0KWoORWxqPQ+bctFbX892FMcAR8oISz2KoMhDtIqOacZ+CdbZtLBbA/rLaKKQZl0BmK9N4jyTHV1FHadUtaYl2VimKrwpuD3eR+3Ju1JH2QwULfqNfYaHiAtEpt91JYr+FSQR9BsUW022spRo/m5vZzJLNnSCZi/oX867aRbhewsE4RTLpAP8PWUVrykHlv0DeRW9ao1XoCcgM1oA5sbvdyIMeHOZokemcHRFAn7dXfKkpytMC/XatCKdT0bjSmpBjvPucaHUrD0ipCxxXL5pwviLyuz8vwkh2yKFGXZgeJX9DABCFXMkwFJRyZTkaiZHC3e06gneah0YLl0PuBRFDO9s12xsAkPREQbUcvV2yWDZHezmdhC2+lpZlmwjB+qd0p4AOo2E0sNV378WUniegkX4iqsg9RdRo3ERTAS3nxMyClDnb4Ni40RHHKbqNiR/Xd0NkQ3ZN/gxhphIt6uiHDDhdFhk= user@kirill-desktop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID+6UNj+Sr6/7buMrcgG1lzs0fBNRBITM3oImgyJDmHk clackgot@91.108.227.42"
    ];
  };
}