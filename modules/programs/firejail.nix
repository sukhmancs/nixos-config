#
#  Firejail - Sandbox programs to give them restricted permissions
#

{ config, pkgs, lib, ... }:

with lib;
{
  options.firejail = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = mdDoc ''
        Firejail - Sandbox programs to give them restricted permissions
      '';
    };
  };

  config = mkIf config.firejail.enable {
    # enable firejail
    programs.firejail.enable = true;
    # create system-wide executables firefox and chromium
    # that will wrap the real binaries so everything
    # work out of the box.
    programs.firejail.wrappedBinaries = { 
      chromium = {
          executable = "${pkgs.lib.getBin pkgs.chromium}/bin/chromium";
          profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
      };
      firefox = {
          executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
          profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
      };
    }; 
  };
}
