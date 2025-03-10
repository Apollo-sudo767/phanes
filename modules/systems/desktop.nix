{ pkgs, lib, username, ... }:

{
  # Define user group
  users.groups.${username} = {};
  
  # Define user account
  users.users.${username} = {
    isNormalUser = true; # Set to true or false depending on your needs
    description = "${username}";
    extraGroups = ["networkmanager" "wheel" "vboxusers"];
    group = "${username}"; # This must match the username
  };
  
  users.extraGroups.vboxusers.members = [ "apollo" ];
  # Trusted users
  nix.settings.trusted-users = [username];

  # Nix settings
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = ["https://cache.nixos.org"];
    trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
    builders-use-substitutes = true;
  };

  # Garbage collection
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Time zone and locales
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Printing
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  # Xbox controller support
  hardware.xone.enable = true;

  # Fonts
  fonts = {
    packages = with pkgs;  [
        material-design-icons
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-code
        cinzel
      ];
    
    enableDefaultPackages = false;
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  # Programs
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    dconf.enable = true;
  };

  # SSH
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      UseDns = true;
    };
    openFirewall = true;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    sysstat
    lm_sensors
    scrot
    fastfetch
    xfce.thunar
    nnn
    blueman
    mangohud
    bluez
    pamixer
    playerctl
    github-desktop
    gh
    cmus
    gnutar
    gzip
    vulkan-tools
    mesa
    neovim
    protontricks
    libreoffice-qt6-fresh
    vlc
    thunderbird
    ncspot
    spotify
    waypipe
    
    # Drivers
    hplip
    hplipWithPlugin
    numlockx

    # Style Packages
    # cavalier
    cbonsai
    cmatrix
    pipes
    asciiquarium
  ];

  # Home Manager
  home-manager.backupFileExtension = "backup";

  # Stylix
   stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://live.staticflickr.com/65535/52211883799_9642668157_o_d.png";
      sha256 = "5bdc52f583da6dc14c26ac3f00d1e5ff45ae7a1da3820d5abf4076b512e18e76";
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";

      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "Dejavu Sans";

      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "Dejavu Serif";
      };
      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };
    };
    opacity = {
      applications = 1.0;
      terminal = 0.8;
      desktop = 1.0;
      popups = 1.0;
    };
    polarity = "dark";
  };

  # Services
  services = {
    xserver = {
      enable = true;
      xkb = {
        variant = "";
        layout = "us";
      };
      excludePackages = [ pkgs.xterm ];
      videoDrivers = ["nvidia"];
      displayManager = {
        gdm.enable = true;
      };
    };
    libinput.enable = true;
    # desktopManager = {
    #   cosmic-greeter.enable = true;
    # };
    dbus.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
  };

  # Kitty Config
  environment.etc."kitty/kitty.conf".text = ''
    background_opacity 0.8
    '';
  # Nixpkgs
  nixpkgs.config.allowUnfree = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  
  # Sound
  services.pulseaudio.enable = false;

  # Power profiles and policy kit
  # services.power-profiles-daemon.enable = true; # Battery Daemon replaced by TLP
  security.polkit.enable = true;
   
  # Services
  services.dbus.packages = [pkgs.gcr];
  services.geoclue2.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.flatpak.enable = true;
  services.udev.packages = with pkgs; [gnome-settings-daemon];
}
