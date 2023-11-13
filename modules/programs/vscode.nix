# enable and customize vscode for current user
{ pkgs, vars, ... }:

{
  home-manager.users.${vars.user} = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
      bbenoist.nix
      jnoortheen.nix-ide
      ms-python.python
      ];
      userSettings = {"files.autoSave" = "on";};
    };   
  };
}
