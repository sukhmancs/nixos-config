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
    kernelModules = [ "kvm-intel" "wl" ];
    kernelParams = [ "intel_iommu=on" "iommu=pt" ];
    #extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
    blacklistedKernelModules = [ "bcma" ];
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
      unityhub
      virtiofsd         # Needed for shared folder setup in virt-manager
      goldendict-ng     # Dictionary - Ctrl + C, C to open dictionary lookup
    ];
  };


  services = {                            # Extra config options for systemd-logind
    logind = {
      extraConfig = ''
        IdleAction=lock 
        Audit=yes 
        NAutoVTs=6 
        ReserveVT=6 
        IdleActionSec=30min 
        RuntimeDirectorySize=40%
      '';
    };
  };

  #hardware.facetimehd.enable = true;        # facetimehd support for macbook Facetime HD camera

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
