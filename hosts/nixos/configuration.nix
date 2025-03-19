# Common NixOS configuration shared by all machines
{ lib, config, pkgs, inputs, outputs, ... }:

{
  # Import your hardware configuration but we'll handle this per-host
  # imports = [ ./hardware-configuration.nix ];
  
  # Common Packages
  environment.systemPackages = with pkgs; [
    wget
    # neovim # Removed due to nixvim being on all systems
    curl 
    git 
    sysstat
    lm_sensors
    scrot
    fastfetch
    blueman
    waypipe
    # hplip
    # hplipWithPlugin
    sd-switch
  ];

  # Bootloader and kernel
  boot = {
    # Use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;
    
    # Boot loader configuration (from your original config)
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Networking basics - host-specific configs will be in their respective directories
  networking = {
    networkmanager.enable = true;
  };

  # Time zone and locale settings from your original config
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Console keymap
  console.keyMap = "us";

  # Enable sound with pipewire (from your original config)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Fonts configuration
   fonts = {
    packages = with pkgs;  [
        material-design-icons
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        jetbrains-mono
        fira-code
      # cinzel
      ];
    
    enableDefaultPackages = false;
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };
  # Enable SSH service
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };
  
  # Programs
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "z"
        "sudo"
        "colored-man-pages"
        "extract"
        "history-substring-search"
      ];
    };
    interactiveShellInit = ''
      export EDITOR=nvim
      export PATH="$HOME/.local/bin:$PATH"
      setopt HIST_IGNORE_ALL_DUPS
      setopt SHARE_HISTORY
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';
  };
  
  # User Settings
  users.users = {
    apollo = {
      isNormalUser = true;
      group = "apollo";
      extraGroups = [ "wheel" "networkmanager" ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "SHA256:Ib5d4lKSIShSxgx02cOAsIi+vCeImZoBBMB2Ees3aGc fireshifter767@gmail.com"
      ];
    };
    hermes = {
      isNormalUser = true;
      group = "hermes";
      extraGroups = [ "wheel" "networkmanager" ];
      shell = pkgs.zsh;
    };
    aries = {
      isNormalUser = true;
      group = "aries";
      extraGroups = [ "wheel" "networkmanager" ];
      shell = pkgs.zsh;
    };
  };
  
  users.groups = {
    apollo = {};
    hermes = {};
    aries = {};
  };

  # Nix daemon settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
  
  # Don't require password for sudo
  security.sudo.wheelNeedsPassword = true;
  
  # Allow Unfree Packages
  nixpkgs.config.allowUnfree = true;

}
