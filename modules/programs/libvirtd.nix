#
#  Virtualisation using libvirt and virt-manager
#

{ pkgs, vars, lib, ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  home-manager.users.${vars.user} = {
    dconf.settings = {      
      "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
      };
    }; 
  };
}
