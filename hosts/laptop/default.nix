#
#  Specific system configuration settings for laptop
#
#  flake.nix
#   ├─ ./hosts
#   │   ├─ default.nix
#   │   └─ ./laptop
#   │        ├─ default.nix *
#   │        └─ hardware-configuration.nix
#   └─ ./modules
#       └─ ./desktops
#           ├─ bspwm.nix
#           └─ ./virtualisation
#               └─ docker.nix
#

{ config, pkgs, vars, ... }:

{
  imports = 
  [ 
    ./hardware-configuration.nix 
    ../../modules/services/wifi/wifi.nix
    #../../modules/profiles/nixos_hardened.nix
  ] ++
  ( import ../../modules/desktops/virtualisation );

  boot = {                                  # Boot Options
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {                              # Grub Dual Boot
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;                 # Find All Boot Options
        configurationLimit = 2;
      };
      timeout = 1;
    };
  };

  hardware.sane = {                         # Scanning
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  laptop.enable = true;                     # Laptop Modules
  bspwm.enable = true;                      # Window Manager
#  gnome.enable = true;

  environment = {
    systemPackages = with pkgs; [           # System-Wide Packages
      simple-scan       # Scanning
      onlyoffice-bin    # Office
      kazam             # Recording
    ];
  };

  programs.light.enable = true;             # Monitor Brightness

  services = {
    printing = {                            # Printing and drivers for TS5300
      enable = true;
      drivers = [ pkgs.cnijfilter2 ];
    };
  };

  systemd.tmpfiles.rules = [                # Temporary Bluetooth Fix
    "d /var/lib/bluetooth 700 root root - -"
  ];
  systemd.targets."bluetooth".after = ["systemd-tmpfiles-setup.service"];
}
