###
### Setup MIME types for applications ### 
### This will setup which application will open which file based on its MIME type

{ pkgs, vars, ... }:

{
  home-manager.users.${vars.user} = {
    xdg = {
      mime.enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = {
          "image/jpeg" = ["image-roll.desktop" "feh.desktop"];
          "image/png" = ["image-roll.desktop" "feh.desktop"];
          "text/plain" = "nvim.desktop";
          "text/html" = "nvim.desktop";
          "text/csv" = "nvim.desktop";
          "application/pdf" = [ "wps-office-pdf.desktop" "firefox.desktop" "google-chrome.desktop"];
          "application/zip" = "org.gnome.FileRoller.desktop";
          "application/x-tar" = "org.gnome.FileRoller.desktop";
          "application/x-bzip2" = "org.gnome.FileRoller.desktop";
          "application/x-gzip" = "org.gnome.FileRoller.desktop";
          # "application/x-bittorrent" = "";
          "x-scheme-handler/http" = ["firefox.desktop" "google-chrome.desktop"];
          "x-scheme-handler/https" = ["firefox.desktop" "google-chrome.desktop"];
          "x-scheme-handler/about" = ["firefox.desktop" "google-chrome.desktop"];
          "x-scheme-handler/unknown" = ["firefox.desktop" "google-chrome.desktop"];
          "x-scheme-handler/mailto" = ["gmail.desktop"];
          "audio/mp3" = "mpv.desktop";
          "audio/x-matroska" = "mpv.desktop";
          "video/webm" = "mpv.desktop";
          "video/mp4" = "mpv.desktop";
          "video/x-matroska" = "mpv.desktop";
          "inode/directory" = "pcmanfm.desktop";
        };
      };
      desktopEntries.image-roll = {
        name = "image-roll";
        exec = "${pkgs.image-roll}/bin/image-roll %F";
        mimeType = ["image/*"];
      };
      desktopEntries.gmail = {
        name = "Gmail";
        exec = ''xdg-open "https://mail.google.com/mail/?view=cm&fs=1&to=%u"'';
        mimeType = ["x-scheme-handler/mailto"];
      };
    };
  };
}
