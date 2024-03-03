{ pkgs, vars, ... }:

{
  # required to run chromium
  security.chromiumSuidSandbox.enable = true;

  programs.chromium = {
    enable = true;
#    extensions = [
#      "mbniclmhobmnbdlbpiphghaielnnpgdp" # lightshot
#      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
#      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
#      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # privacy badger
#      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
#    ];
    extraOpts = {
      "BrowserSignin" = 0;
      "SyncDisabled" = true;
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = ["en-US"];
      "DefaultCookiesSetting" = 4;             # Remove cookies after session closed
      "DefaultFileSystemReadGuardSetting" = 2; # Deny read access to files on system
      "DefaultGeolocationSetting" = 3;         # Ask the user when site want to track user location
      "DefaultLocalFontsSetting" = 2;
      "DeviceAutoUpdateDisabled" = true;       # Disable auto update
      ExtensionSettings = {
        "*" = {
          "allowed_types" = [
           "extension"
          ];
          "blocked_install_message" = "You do not have permissions to install extensions. Change NixOS chromium policies.";
          "blocked_permissions" = [
           "downloads"
           "bookmarks"
          ];
          "installation_mode" = "blocked"; 
        };
        "abcdefghijklmnopabcdefghijklmnop" = {
          "blocked_permissions" = [
           "history"
          ];
          "installation_mode" = "allowed";
          "minimum_version_required" = "1.0.1";
          "toolbar_pin" = "force_pinned";
          "file_url_navigation_allowed" = true;
        };
        "dbepggeogbaibhgnhhndojpepiihcmeb" = { # vimium
          "installation_mode" = "force_installed";
          "override_update_url" = true;
          "update_url" = "https://clients2.google.com/service/update2/crx";
        };
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" = { # ublock
          "installation_mode" = "force_installed";
          "override_update_url" = true;
          "update_url" = "https://clients2.google.com/service/update2/crx";
        };
        "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" = { # privacy badger
          "installation_mode" = "force_installed";
          "override_update_url" = true;
          "update_url" = "https://clients2.google.com/service/update2/crx";
        };
        "hnmpcagpplmpfojmgmnngilcnanddlhb" = { # Windscribe
          "installation_mode" = "allowed";
        };
      };
    };
  };
}
