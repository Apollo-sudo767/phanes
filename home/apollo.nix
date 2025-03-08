# Home configuration for apollo
{ inputs, outputs, lib, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "apollo";
  home.homeDirectory = lib.mkDefault (
    if pkgs.stdenv.isDarwin then "/Users/apollo" else "/home/apollo"
  );

  # Packages to install
  home.packages = with pkgs; [
    # CLI tools
    ripgrep
    fd
    fzf
    jq
    yq
    eza
    bat
    
    # Development tools
    nodejs
    python3
    rustup

    # GUI applications
    firefox
    vscode
    spotify
    
    # Additional tools from your original config
    neofetch
    btop
    vim
  ];

  # Shell configuration (based on your original home.nix)
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ll = "eza -l";
      la = "eza -la";
      ".." = "cd ..";
      gs = "git status";
      gc = "git commit";
      gp = "git push";
    };
    
    initExtra = ''
      # Custom Zsh configuration
      bindkey -e  # Use emacs key bindings
      
      # Set prompt
      PROMPT='%B%F{cyan}%n%f%b@%B%F{magenta}%m%f%b:%B%F{blue}%~%f%b$ '
    '';
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Apollo";
    userEmail = "apollo@example.com";  # Replace with your actual email
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  # Alacritty configuration
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      font.size = 12.0;
      
      # Colors based on your theme preferences
      colors = {
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
      };
    };
  };

  # Neovim configuration
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      nvim-treesitter
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local lspconfig = require('lspconfig')
          lspconfig.pyright.setup{}
          lspconfig.rust_analyzer.setup{}
        '';
      }
    ];
  };

  # Visual Studio Code
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      yzhang.markdown-all-in-one
      jnoortheen.nix-ide
    ];
    userSettings = {
      "editor.fontFamily" = "'Fira Code', monospace";
      "editor.fontSize" = 14;
      "editor.fontLigatures" = true;
      "workbench.colorTheme" = "Default Dark+";
    };
  };

  # Awesome WM configuration (moved from your original config)
  xdg.configFile."awesome" = {
    source = ./dotfiles/awesome;
    recursive = true;
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Home Manager state version
  home.stateVersion = "23.11";
}
