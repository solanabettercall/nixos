_:

{
  users.users.clackgot = {
    isNormalUser = true;
    home = "/home/clackgot";
    createHome = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = (import ../ssh-keys.nix).admin;
  };
}
