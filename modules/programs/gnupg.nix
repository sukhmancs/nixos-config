{ config, pkgs, ... }:

{
  # Enable the GnuPG module
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
#    pinentryPackage = pkgs.pinentry-gnome3; # provides better security for password entries

    settings = {
      default-cache-ttl = 1800; # 30 minutes
      max-cache-ttl = 3600; # 60 minutes
      debug-level = 4; # Advanced      
    };
  };
}
