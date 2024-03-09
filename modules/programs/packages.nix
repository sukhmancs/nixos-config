{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [           

      # System-Wide Packages
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
      dpkg              # Debian package manager
      file              # Get File Information
      tree              # Print Directory Tree
      steam-run         # Run commands in the same FHS environment
      google-chrome     # A freeware browser developed by Google

      # Video/Audio
      alsa-utils        # Audio Control
      feh               # Image Viewer
      image-roll        # Image Viewer
      mpv               # Media Player
      pavucontrol       # Audio Control
      pipewire          # Audio Server/Control
      pulseaudio        # Audio Server/Control
      vlc               # Media Player
      stremio           # Media Streamer

      # Apps
      appimage-run      # Runs AppImages on NixOS
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
      bleachbit         # A program to free up disk space

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
      glib                   # C library
      tor-browser-bundle-bin
      profile-sync-daemon    # CONFIGURE ME (check out Archlinux wiki for profile-sync-daemon)
                             # Syncs browser profile dirs to RAM
                             # Run command 'psd' for the first time use, then configure it in $XDG_CONFIG_HOME/psd/psd.conf

    #### System hardening

      #chkrootkit         # Scan for any rootkits
      clamav             # Antivirus
      vulnix             # NixOS vulnerability scanner
      lynis              # Security auditing tool
  ];
}
