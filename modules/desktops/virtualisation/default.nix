#
#  Virtualisation Modules
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./<host>
#   │       └─ default.nix
#   └─ ./modules
#       └─ ./desktop
#           └─ ./virtualisation
#               ├─ default.nix *
#               └─ ...
#

[
  #./docker.nix
  ./qemu.nix
#  ./vfio.nix
  #./x11vnc.nix
]
