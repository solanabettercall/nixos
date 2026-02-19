{
  add_newline = true;

  format = ''
    $os$username$hostname$directory$git_branch$git_status$git_state$nix_shell$python$nodejs$rust$golang$lua$cmd_duration
    $character'';

  # ── OS ────────────────────────────────────────────────────────────────
  os = {
    disabled = false;
    style = "fg:#89b4fa";
    symbols = {
      NixOS = " ";
      Linux = " ";
      Macos = " ";
      Windows = " ";
    };
  };

  # ── Username ──────────────────────────────────────────────────────────
  username = {
    show_always = false;
    style_user = "bold fg:#cba6f7";
    style_root = "bold fg:#f38ba8";
    format = "[$user]($style) ";
  };

  # ── Hostname ──────────────────────────────────────────────────────────
  hostname = {
    ssh_only = true;
    style = "bold fg:#89dceb";
    format = "[@$hostname]($style) ";
  };

  # ── Directory ─────────────────────────────────────────────────────────
  directory = {
    style = "bold fg:#89b4fa";
    read_only_style = "fg:#f38ba8";
    read_only = " 󰌾";
    truncation_length = 3;
    truncate_to_repo = true;
    format = "[$path]($style)[$read_only]($read_only_style) ";
    substitutions = {
      "~" = "󱉭 ";
      "Documents" = "󰈙 ";
      "Downloads" = " ";
      "Music" = "󰝚 ";
      "Pictures" = "󰋩 ";
      "Videos" = "󰕧 ";
      "Desktop" = "󰚀 ";
      ".config" = " ";
      "Projects" = "󰏗 ";
    };
  };

  # ── Git branch ────────────────────────────────────────────────────────
  git_branch = {
    symbol = " ";
    style = "fg:#a6e3a1";
    format = "[$symbol$branch(:$remote_branch)]($style) ";
    truncation_length = 20;
    truncation_symbol = "…";
  };

  # ── Git status ────────────────────────────────────────────────────────
  git_status = {
    style = "fg:#f9e2af";
    format = "([$all_status$ahead_behind]($style))";
    conflicted = "󰞇 ";
    ahead = "󰶣 \${count}";
    behind = "󰶡 \${count}";
    diverged = "󰆗 ";
    untracked = "󰋗 \${count}";
    stashed = "󱉙 ";
    modified = " \${count}";
    staged = "󰐕 \${count}";
    renamed = "󰑕 \${count}";
    deleted = "󰆴 \${count}";
  };

  # ── Git state ─────────────────────────────────────────────────────────
  git_state = {
    style = "bold fg:#f38ba8";
    format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
  };

  # ── Nix shell ─────────────────────────────────────────────────────────
  nix_shell = {
    symbol = " ";
    style = "bold fg:#89b4fa";
    format = "[$symbol$state( \\($name\\))]($style) ";
    impure_msg = "impure";
    pure_msg = "pure";
  };

  # ── Languages ─────────────────────────────────────────────────────────
  python = {
    symbol = " ";
    style = "fg:#f9e2af";
    format = "[$symbol$pyenv_prefix($version)(\\($virtualenv\\))]($style) ";
  };

  nodejs = {
    symbol = " ";
    style = "fg:#a6e3a1";
    format = "[$symbol($version)]($style) ";
  };

  rust = {
    symbol = " ";
    style = "fg:#fab387";
    format = "[$symbol($version)]($style) ";
  };

  golang = {
    symbol = " ";
    style = "fg:#89dceb";
    format = "[$symbol($version)]($style) ";
  };

  lua = {
    symbol = " ";
    style = "fg:#89b4fa";
    format = "[$symbol($version)]($style) ";
  };

  # ── Command duration ──────────────────────────────────────────────────
  cmd_duration = {
    min_time = 2000;
    style = "fg:#6c7086";
    format = "[󱦟 $duration]($style) ";
    show_notifications = false;
  };

  # ── Prompt character ──────────────────────────────────────────────────
  character = {
    success_symbol = "[❯](bold fg:#a6e3a1)";
    error_symbol = "[❯](bold fg:#f38ba8)";
    vimcmd_symbol = "[❮](bold fg:#cba6f7)";
  };

  # ── Отключить лишнее ──────────────────────────────────────────────────
  package.disabled = true;
  time.disabled = true;
}
