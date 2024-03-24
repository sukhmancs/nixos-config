{ pkgs, vars, ... }:

let 
  configurationPath = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/sukhmancs/nixos-config/main/modules/services/firewall/nftables.conf?token=GHSAT0AAAAAACNNH7DH6K5B35WIT4FKUGJSZQAMKNA";
    sha256 = "04zrvv0s4118gvr2apmrmm8prg4p2by806r8066dk76y23vry5in";
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

