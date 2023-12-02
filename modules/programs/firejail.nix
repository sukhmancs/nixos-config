#
#  Firejail - Sandbox programs to give them restricted permissions
#

{ pkgs, lib, ... }:

{
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      firefox = {
        executable = "${lib.getBin pkgs.firefox}/bin/firefox";
        profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
      };
    };
  };
}
