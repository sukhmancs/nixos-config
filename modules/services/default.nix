#
#  Services
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ configuration.nix
#   └─ ./modules
#       └─ ./services
#           └─ default.nix *
#               └─ ...
#

[
  ./avahi.nix
  ./dunst.nix
  ./flameshot.nix
  ./picom.nix
  ./polybar.nix
  ./samba.nix
  ./sxhkd.nix
  ./udiskie.nix
  ./clamav.nix
  ./media.nix
  ./mime_types.nix
  ./audit.nix
  #./startup_service.nix
  ./polkit_service.nix
  ./psd.nix
  ./vastai_certificates.nix
 # ./firewall.nix  # comment this line as a workaround when using virt-manager because libvirt uses iptables and i am using nftables so they are in conflict (TODO). 
  ./pam.nix
]

