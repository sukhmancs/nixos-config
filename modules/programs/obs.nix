{ config, lib, pkgs, vars, ... }:

with lib;
{
  options.obs = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = mdDoc ''
        OBS studio - video, screen recorder
      '';
    };
  };

  config = mkIf config.obs.enable {
    home-manager.users.${vars.user} = {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          advanced-scene-switcher
        ];
      };
    };
  };
}
