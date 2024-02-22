###
### Nix-index provides a "command-not-found" script. 
###
### Example output: 
### $ blender
###  The program 'blender' is currently not installed. You can install it
###  by typing:
###    nix-env -iA nixpkgs.blender.out
###  
###  Or run it once with:
###    nix-shell -p blender.out --run ...
###

{ pkgs, ... }:

{
  # use "command-not-found" script provided by nix-shell
  programs.command-not-found.enable = false;

  # for home-manager, use programs.bash.initExtra instead
  programs.zsh.interactiveShellInit =
  ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';
}
