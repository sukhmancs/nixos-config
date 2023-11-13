#
#  System Notifications
#

{ config, lib, pkgs, vars, ... }:

let
  pkgs_pcloud = import (builtins.fetchGit {
      # Descriptive name to make the store path easier to identify
      name = "my-old-revision";
      url = "https://github.com/NixOS/nixpkgs/";
      ref = "refs/heads/nixpkgs-unstable";
      rev = "8ad5e8132c5dcf977e308e7bf5517cc6cc0bf7d8";
    }) {config.allowUnfree = true;};

#  flakeScript = import /home/sukhman/Documents/sway_related/flake.nix;
  myPkg = pkgs_pcloud.pcloud;
in
{
  home-manager.users.${vars.user} = {
    home.packages = [
      myPkg
    ];
  };
}
