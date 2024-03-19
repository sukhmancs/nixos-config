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

  users.groups.audit = {};
  users.users.${vars.user} = {              # System User
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" "kvm" "libvirtd" "plex" "vboxusers" "audit" ];
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
  };

  environment.shellAliases = {
    git-bare = "git --git-dir=$HOME/nixos-config-bare-repo/ --work-tree=/etc/nixos";
  };

  virtualisation.vmware.host.enable = true;
  virtualisation.vmware.guest.enable = true;

  programs = {
    dconf.enable = true;
  };

  pass.enable = true;                       # Pass password manager with rofi-pass and other extensions enabled

  pcloud.enable = true;                     # Enable pcloud

  firefox-with-policies.enable = true;      # Enable firefox with enterprise policies

  nix-index-cnf.enable = true;              # Nix-index with command-not-found script

  nix-ld.enable = true;                     # nix-ld

  firejail = {
    enable = true;                          # Sandbox
    profilesGitHub = {
      owner = "chiraag-nataraj";
      repo = "firejail-profiles";
      rev = "fcd08dd32874f9fb5c856375659c434c922f156a";
      sha256 = "1w2j7bispzs0c8k8ic45m9bx6vlwddak7y829rg1j8ycqy6wazc3";
    };
  };

  chromium-policies.enable = true;          # Enable chromium enterprise policies

  vscode-custom.enable = true;              # vscode with custom settings and extensions

  clamav.enable = true;                     # Antivirus

  psd.enable = true;                        # profile-sync-daemon

  polkit-agent.enable = true;               # enable polkit_gnome polkit agent for better interface for polkit daemon

  wifi.enable = true;                       # Wifi - Setup Network manager with dnscrypt-proxy client. It also configures fail to ban and Network Manager applet

  certificates.enable = true;               # Enable system-wide certificates eg, for vast.ai
  sysctl.enable = true;                     # Kernel Parameters using sysctl

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
