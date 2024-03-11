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
  ./startup_service.nix
  ./polkit_service.nix
  ./psd.nix
]

