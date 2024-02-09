#
#  Main system configuration. More information available in configuration.nix(5) man page.
#
#  flake.nix
#   ├─ ./hosts
#   │   ├─ default.nix
#   │   └─ configuration.nix *
#   └─ ./modules
#       ├─ ./desktops
#       │   └─ default.nix
#       ├─ ./editors
#       │   └─ default.nix
#       ├─ ./hardware
#       │   └─ default.nix
#       ├─ ./programs
#       │   └─ default.nix
#       ├─ ./services
#       │   └─ default.nix
#       ├─ ./shell
#       │   └─ default.nix
#       └─ ./theming
#           └─ default.nix
#

{ config, lib, pkgs, inputs, vars, ... }:

{
  imports = ( import ../modules/desktops ++
              import ../modules/editors ++
              import ../modules/hardware ++
              import ../modules/programs ++
              import ../modules/services ++
              import ../modules/shell ++
              import ../modules/theming );

  users.users.${vars.user} = {              # System User
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" "kvm" "libvirtd" "plex" "vboxusers" ];
  };

  time.timeZone = "America/Toronto";        # Time zone and Internationalisation
  i18n = {
    defaultLocale = "en_CA.UTF-8";
  }; 

  console = {
    keyMap = "dvorak";
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  fonts.packages = with pkgs; [             # Fonts
    carlito                                 # NixOS
    vegur                                   # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome                            # Icons
    corefonts                               # MS
    (nerdfonts.override {                   # Nerdfont Icons override
      fonts = [
        "FiraCode"
      ];
    })
  ];

  environment = {
    variables = {                           # Environment Variables
      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    systemPackages = with pkgs; [           # System-Wide Packages
      # Terminal
      btop              # Resource Manager
      coreutils         # GNU Utilities
      git               # Version Control
      killall           # Process Killer
      nano              # Text Editor
      pciutils          # Manage PCI
      ranger            # File Manager
      tldr              # Helper
      usbutils          # Manage USB
      wget              # Retriever

      # Video/Audio
      alsa-utils        # Audio Control
      feh               # Image Viewer
      mpv               # Media Player
      pavucontrol       # Audio Control
      pipewire          # Audio Server/Control
      pulseaudio        # Audio Server/Control
      vlc               # Media Player
      stremio           # Media Streamer

      # Apps
      appimage-run      # Runs AppImages on NixOS
      firefox           # Browser
      google-chrome     # Browser
      remmina           # XRDP & VNC Client

      # File Management
      gnome.file-roller # Archive Manager
      okular            # PDF Viewer
      pcmanfm           # File Browser
      p7zip             # Zip Encryption
      rsync             # Syncer - $ rsync -r dir1/ dir2/
      unzip             # Zip Files
      unrar             # Rar Files
      zip               # Zip

      # My Packages
      networkmanagerapplet
      neofetch
      tldr
      discord
      keepassxc
      arandr
      joplin-desktop
      gimp
      calibre
      telegram-desktop
      xwinwrap
      mailutils
      tesseract4
      tor-browser-bundle-bin

    #### System hardening

      #chkrootkit         # Scan for any rootkits
      clamav             # Antivirus
      vulnix             # NixOS vulnerability scanner
      lynis              # Security auditing tool
    ];
  };

  environment.shellAliases = {
    git-bare = "git --git-dir=$HOME/nixos-config-bare-repo/ --work-tree=/etc/nixos/nixos-config";
  };

  virtualisation.vmware.host.enable = true;
  virtualisation.vmware.guest.enable = true;

  programs = {
    dconf.enable = true;
  };

  services = {
    printing = {                            # CUPS
      enable = true;
    };
    pipewire = {                            # Sound
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
  };

  flatpak.enable = true;                    # Enable flatpak

  nix = {                                   # Nix Package Manager Settings
    settings ={
      auto-optimise-store = true;
    };
    gc = {                                  # Garbage Collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;    # Enable Flakes
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;        # Allow Proprietary Software.

  system = {                                # NixOS Settings
    #autoUpgrade = {                        # Allow Auto Update (not useful in flakes)
    #  enable = true;
    #  channel = "https://nixos.org/channels/nixos-unstable";
    #};
    stateVersion = "22.05";
  };

  home-manager.users.${vars.user} = {       # Home-Manager Settings
    home = {
      stateVersion = "22.05";
    };

    programs = {
      home-manager.enable = true;
    };
  };
}
