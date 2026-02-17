{ ... }:
{
  programs.git = {
    enable = true;
    userName  = "solanabettercall";
    userEmail = "solanabettercall@gmail.com";
    extraConfig = {
      credential.helper  = "store";
      init.defaultBranch = "master";
      pull.rebase        = false;
    };
  };
}