#
#  Services and Timers
#

{ pkgs, vars, lib, ... }:

{
  home-manager.users.${vars.user} = {
    # This timer runs bash script startup_commands.sh on every boot
    systemd.user.services = {
      startup_commands = {
        Unit = {
          Description = "startup_commands service";
        };
        Service = {
          Type = "oneshot";
          ExecStart = toString (
            pkgs.writeShellScript "startup_commands_script" 
            ''
              PATH=$PATH:${lib.makeBinPath [ pkgs.dunst pkgs.megasync pkgs.networkmanagerapplet pkgs.chkrootkit pkgs.pcloud pkgs.goldendict-ng ]}
            
            ${pkgs.bash}/bin/bash "/home/sukhman/.nixos-config/modules/programs/startup_commands.sh";  	 
            ''
  	);
        };
        Install.WantedBy = [ "default.target" ];
      };
    };
  
    systemd.user.timers = {
      startup_commands = {
        Unit.Description = "timer for startup_commands service";
        Timer = {
          Unit = "startup_commands";
  	      OnStartupSec = "3"; # run it at every boot
        };
        Install.WantedBy = [ "timers.target" ];
      };
    };
  
   # This timer runs every day to run bash script nixos_backup.sh
#    systemd.user.services = {
#      nixos_backup = {
#        Unit = {
#          Description = "nixos backup service";
#        };
#        Service = {
#          Type = "oneshot";
#          ExecStart = toString (
#           pkgs.writeShellScript "nixos_backup_script" ''
#            PATH=$PATH:${lib.makeBinPath [ pkgs.rsync ]}
#            ${pkgs.bash}/bin/bash "/home/sukhman/Documents/sway_related/nixos_backup.sh";
#  	 ''
#  	);
#        };
#        Install.WantedBy = [ "default.target" ];
#      };
#    };
#  
#    systemd.user.timers = {
#      nixos_backup = {
#        Unit.Description = "timer for nixos backup service";
#        Timer = {
#          Unit = "nixos_backup";
#  	      OnStartupSec = "5m";
#        };
#        Install.WantedBy = [ "timers.target" ];
#      };
#    };
  };

  # Start polkit agent (i.e. polkit_gnome), a better interface for polkit daemon
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
}
