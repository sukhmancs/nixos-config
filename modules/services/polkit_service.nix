#
# Start polkit agent (i.e. polkit_gnome), a better interface for polkit daemon
#

{ config, pkgs, vars, lib, ... }:

with lib;
{
  options.polkit-agent = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = mdDoc ''
        Start polkit agent (i.e. polkit_gnome), a better interface for polkit daemon
      '';
    };
  };

  config = mkIf config.polkit-agent.enable {
    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
        };
      };
    };
  };
}
