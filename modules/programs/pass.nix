#
# Pass - Password Store password manager with rofi-pass and other extensions enabled
#

{ config, lib, pkgs, vars, ... }:

with lib;

let
  cfg = config.pass;
in
{
  options.pass = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = mdDoc ''
        pass - Password Store password manager with rofi-pass support and other extensions
      '';
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = [
#      pkgs.pass
      (pkgs.pass.withExtensions (exts: [ exts.pass-otp exts.pass-audit exts.pass-update exts.pass-import]))
#      pkgs.pass-git-helper
#      pkgs.passExtensions.pass-otp
#      pkgs.passExtensions.pass-audit
#      pkgs.passExtensions.pass-update
#      pkgs.passExtensions.pass-import
      pkgs.qtpass
      pkgs.pwgen
      pkgs.rofi-pass
    ];

    home-manager.users.${vars.user} = {
      home.file.".config/rofi-pass" = {
        source = ./rofi-pass;
        recursive = true;
      };

      home.file.".config/pass-git-helper" = {
        source = ./git-pass-mapping;
        recursive = true;
      };
    };
  };
}
