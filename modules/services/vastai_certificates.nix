#
# Install system-wide certificate for vast.ai
#
{ config, lib, pkgs, ... }:

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
  };

  config = mkIf config.certificates.enable {
  security = {
    pki = {
      certificates = [''
        -----BEGIN CERTIFICATE-----
        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
        U7/jtzPPMsEmgzRX4qay
        -----END CERTIFICATE-----
      ''
      ];      
    };
  };
};
}
