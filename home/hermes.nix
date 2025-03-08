# Home configuration for hermes (server user)
{ inputs, outputs, lib, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "hermes";
  home.homeDirectory = "/home/hermes";

  # Packages to install (server-focused)
  home.packages = with pkgs; [
    # CLI tools
    ripgrep
    fd
    jq
    yq
    htop
    tmux
    neofetch
    
    # Server tools
    iotop
    iftop
    nethogs
    nmap
    dnsutils
    tcpdump
  ];

  # Shell configuration
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ll = "ls -la";
      ".." = "cd ..";
      gs = "git status";
      gc = "git commit";
      gp = "git push";
    };
    
    initExtra = ''
      # Custom Zsh configuration
      bindkey -e  # Use emacs key bindings
      
      # Set prompt - server-specific to distinguish from other machines
      PROMPT='%B%F{red}%n%f%b@%B%F{yellow}%m%f%b:%B%F{green}%~%f%b$ '
    '';
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Hermes";
    userEmail = "hermes@example.com";  # Replace with actual email
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Neovim configuration - server optimized
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-sensible
    ];
  };

  # Tmux configuration - especially useful for server management
  programs.tmux = {
    enable = true;
    shortcut = "a";
    terminal = "screen-256color";
    historyLimit = 10000;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      resurrect
    ];
    extraConfig = ''
      # Additional tmux configuration
      set -g status-style bg=black,fg=white
      set -g window-status-current-style bg=white,fg=black,bold
      
      # Mouse support
      set -g mouse on
    '';
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Home Manager state version
  home.stateVersion = "23.11";
}
