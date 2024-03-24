{ config, pkgs, lib, vars, ... }:

with lib;

let
  cfg = config.services.keepass;
  configFile = pkgs.writeText "keepass.config.xml" cfg.configData;
in
{
  options.services.keepass = {
    enable = mkEnableOption "KeePass";

    configData = mkOption {
      type = types.lines;
      default = "";
      description = ''
        Contents of the KeePass configuration file.
        This configuration file will be enforced and overwrite any user settings.
      '';
    };

    package = mkOption {
      type = types.package;
      default = pkgs.keepass;
      defaultText = literalExpression "pkgs.keepass";
      description = "KeePass package to use.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];       

    home-manager.users.${vars.user} = {
      home.file.".config/KeePass/KeePass.config.xml" = {
        source = configFile;
      };
    };

#   environment.etc."keepass/keepass.config.xml" = {
#      source = configFile;
#      mode = "0644";
#    };
  };
}
