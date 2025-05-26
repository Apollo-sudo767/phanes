{
  lib,
  pkgs,
  catppuccin-bat,
  ...
}: {
  
  #nixpkgs.config.allowUnfree = true;
  
  home.packages = with pkgs; [
    # archives
    zip
    unzip

    # utils
    ripgrep

    # misc
    libnotify
    wineWowPackages.wayland
    xdg-utils
    libnotify
  ];

  programs = {
    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      extraConfig = "mouse on";
    };

    
    #  }; #looks wrong

    btop.enable = true; # replacement of htop/nmon
    eza.enable = true; # A modern replacement for ‘ls’
    ssh.enable = true;
    

    skim = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'exa --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };
  };

  services = {
    syncthing.enable = true;

    # auto mount usb drives
    udiskie.enable = true;
  };
}
