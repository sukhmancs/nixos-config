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
           pkgs.writeShellScript "startup_commands_script" ''
            PATH=$PATH:${lib.makeBinPath [ pkgs.dunst pkgs.megasync pkgs.networkmanagerapplet pkgs.chkrootkit ]}
            ${pkgs.bash}/bin/bash "/home/sukhman/Documents/sway_related/startup_commands.sh";
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
}
