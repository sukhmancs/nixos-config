#
# Install system-wide certificate for vast.ai
#
{ config, lib, pkgs, vars, ... }:

with lib;
{
  options.certificates = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = mdDoc ''
        Install system-wide certificate eg, for vast.ai
      '';
    };
    certificateFile = mkOption {
      type = types.path;
      default = "/home/${vars.user}/.nixos-config/modules/services/certificates/jvastai_root.cer";
      description = mdDoc ''
        Path to the certificate file.
      '';
    };
  };

  config = mkIf config.certificates.enable {
    security = {
      pki = {
        certificateFiles = [ config.certificates.certificateFile ];
      };
    };
  };
}
