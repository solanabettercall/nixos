{ pkgs, ... }:
{
  home.stateVersion = "25.05";
  
  home.packages = with pkgs; [
    eza
    bat
    git
  ];
  
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ls = "eza --icons --git";
      ll = "eza --icons --git -lh";
      la = "eza --icons --git -lah";
      lt = "eza --icons --git --tree";
      cat = "bat";
    };
    
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" ];
    };
    
    initContent = ''
      # Powerlevel10k instant prompt
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      # Load p10k config
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
  
  home.file.".p10k.zsh".source = ./p10k.zsh;
  
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      style = "plain";
      paging = "never";
    };
  };


  programs.git = {
    enable = true;
    userName = "solanabettercall";
    userEmail = "solanabettercall@gmail.com";
  
    extraConfig = {
      credential.helper = "store";
    };
  };

}
