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
          StandardOutput="journal";
          ExecStart = toString (
            pkgs.writeShellScript "startup_commands_script"
            ''
              PATH=$PATH:${lib.makeBinPath [ pkgs.dunst pkgs.megasync pkgs.networkmanagerapplet pkgs.chkrootkit pkgs.goldendict-ng ]}
#            ${pkgs.bash}/bin/bash "./startup_commands.sh";  
             /run/current-system/sw/bin/pcloud &
             /run/current-system/sw/bin/nm-applet
            ''
  	);
        };
        Install.WantedBy = [ "default.target" ];
      };
    };

#    systemd.user.timers = {
#      startup_commands = {
#        Unit.Description = "timer for startup_commands service";
#        Timer = {
#          Unit = "startup_commands";
#  	      OnBootSec = "5s"; # run it at every login
#        };
#        Install.WantedBy = [ "timers.target" ];
#      };
#    };
  };
}
