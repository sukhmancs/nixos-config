{ config, pkgs, ... }:

{
  # Enable the GnuPG module
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
#    pinentryPackage = pkgs.pinentry-gnome3; # provides better security for password entries

    settings = {
      default-cache-ttl = 10800; # 3 hours (10800 seconds)
      max-cache-ttl = 10800; # 3 hours (10800 seconds)
      debug-level = 4; # Advanced      
    };
  };
}
