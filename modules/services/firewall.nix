#
# nftables configuration 
# 
# use the following command to get rev, hash, and other details about the repository
# nix-prefetch-git https://github.com/<username>/<repo>
#

{ pkgs, vars, ... }:

let 
  # configurationPath = pkgs.fetchurl {
  #   url = "https://raw.githubusercontent.com/sukhmancs/nixos-config/main/modules/services/firewall/nftables.conf";
  #   sha256 = "073k9rnpk380vygy4i7dw0ryfpsb7hwmis0w19y7wns6bhbsi2pa";
  # };
  
  rev = "c21cf636e0aae22ecdff41a8b90fb6672864c3ee";  
  hash = "sha256-Kkx9buPeQEJOxL+UbL/vlRk5xJ3K0ttGkAEQX1y4pIY=";
  configurationPath = pkgs.fetchFromGitHub {
    owner = "sukhmancs";
    repo = "nixos-config";    
    rev = rev;
    hash = hash;
  };
  
  filePath = "${configurationPath}/modules/services/firewall/nftables.conf";
in 
{
  networking = {
    nftables = {
      enable = true;  
      # read content from the configurationPath
      ruleset = builtins.readFile filePath;        
    };
  };
}

