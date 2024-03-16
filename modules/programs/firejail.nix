#
#  Firejail - Sandbox programs to give them restricted permissions
#

{ config, pkgs, lib, ... }:

with lib;
{
  options.firejail = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = mdDoc ''
        Firejail - Sandbox programs to give them restricted permissions
      '';
    };
  };

  config = mkIf config.firejail.enable {
    # enable firejail
    programs.firejail.enable = true;
    # create system-wide executables firefox and chromium
    # that will wrap the real binaries so everything
    # work out of the box.
    programs.firejail.wrappedBinaries = { 
      google-chrome = {
        executable = "${pkgs.lib.getBin pkgs.google-chrome}/bin/google-chrome";
        profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
        extraArgs = [
          # sandbox Xorg to restrict keyloggers
          "--x11=xephyr"
        ];
      };
      firefox = {
        executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
        profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
        extraArgs = [
          # Required for U2F USB stick
          "--ignore=private-dev"
          # Enforce dark mode
          "--env=GTK_THEME=Adwaita:dark"
          # Enable system notifications
          "--dbus-user.talk=org.freedesktop.Notifications"
          # sandbox Xorg to restrict keyloggers
          "--x11=xephyr"
        ];
      };
    }; 
  };
}
