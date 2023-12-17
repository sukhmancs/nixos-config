#
#  Media Services: Plex, Torrenting and Automation
#

{
  services = { 
    deluge = {                  #8112
      enable = true;
      web.enable = true;
      user = "root";
      group = "users";
      openFirewall = true;
      web.openFirewall = true;
    };
  };
}

# literally can't be bothered anymore with user permissions.
# So everything with root, add permissions 775 with group users in radarr and sonarr
# (Under Media Management - Show Advanced | Under Subtitles)
# Radarr & Sonarr: chmod 775
# Bazarr: chmod 664
# Prowlarr should just work
# Deluge: 
#   Connection Manager: localhost:58846
#   Preferences: Change download folder and enable Plugins-label
