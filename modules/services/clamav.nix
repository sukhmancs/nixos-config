#
#  ClamAv - Antivirus
#
{ config, lib, pkgs, ... }:

with lib;
{
  options.clamav = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = mdDoc ''
        ClamAV - Antivirus
      '';
    };
  };

  config = mkIf config.clamav.enable { 
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = [
      pkgs.clamav
    ];

    services = {
      clamav = {
        daemon = {
          enable = true;
        };
        updater = {
          enable = true;
        };
      };
    };
  };
}
