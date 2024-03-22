#
# VSCode-insider
# enable and customize vscode for current user
#
{ config, lib, pkgs, vars, ... }:

{  
  home-manager.users.${vars.user} = {
    programs.vscode = {
      enable = true;
      package = 
      (pkgs.vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: rec {
        src = (builtins.fetchTarball {
          url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
          sha256 = "063y5ava6lyhg9m6pf8lgk7fbqdc8l33yj50r1zlb47mfc690hbc";
        });
        version = "latest";
        
        buildInputs = oldAttrs.buildInputs ++ [ pkgs.krb5 ];
      }); 
      extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
      bbenoist.nix
      jnoortheen.nix-ide
      ms-python.python
      ];
      userSettings = {
        "files.autoSave" = "on";
        "explorer.compactFolders" = false;
        "update.showReleaseNotes" = false;
        "update.mode" = "none";
        "github.copilot.enable" = {
          "markdown" = "true";
          "plaintext" = "true";
        };
      };
    };   
  };
}
