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
      dart-code.flutter
      mkhl.direnv
      ];
      userSettings = {
        "files.autoSave" = "on";
        "explorer.compactFolders" = false;
        "update.showReleaseNotes" = false;
        "explorer.confirmDragAndDrop" = false;
        "workbench.startupEditor" = "none";
        "update.mode" = "none";
        "security.workspace.trust.untrustedFiles" = "open";
        "terminal.integrated.defaultProfile.linux" = "zsh";
        "github.copilot.enable" = {
          "markdown" = "true";
          "plaintext" = "true";
        };
      };
      keybindings = [
        {
          key = "ctrl+c";
          command = "editor.action.clipboardCopyAction";
          when = "textInputFocus";
        }
        {
          key = "shift+enter";
          command = "jupyter.execSelectionInteractive";
          when = "editorTextFocus && isWorkspaceTrusted && jupyter.ownsSelection && !findInputFocussed && !notebookEditorFocused && !replaceInputFocussed && editorLangId == 'python'";
        }
      ];
    };   
  };
}
