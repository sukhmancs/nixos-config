#
# Enable the Profile Sync daemon
# Make sure profile-sync-daemon package is installed
#

{ pkgs, ... }:

{
  services = {
    psd = {
      enable = true;
      resyncTimer = "1h";
    };
  };
}
