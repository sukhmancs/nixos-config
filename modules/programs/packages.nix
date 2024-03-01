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
      #firefox           # Browser
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
      tor-browser-bundle-bin

    #### System hardening

      #chkrootkit         # Scan for any rootkits
      clamav             # Antivirus
      vulnix             # NixOS vulnerability scanner
      lynis              # Security auditing tool
  ];
}
