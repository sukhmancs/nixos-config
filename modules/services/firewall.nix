{ pkgs, vars, ... }:

let 
  configurationPath = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/sukhmancs/nixos-config/main/modules/services/firewall/nftables.conf\?token\=GHSAT0AAAAAACNNH7DGS75W5U4YAO4FMRL6ZQCGBYQ";
    sha256 = "073k9rnpk380vygy4i7dw0ryfpsb7hwmis0w19y7wns6bhbsi2pa";
  };
in 
{
  networking = {
    nftables = {
      enable = true;  
      # read content from the configurationPath
      ruleset = builtins.readFile configurationPath;        
    };
  };
}

