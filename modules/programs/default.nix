#
#  Apps
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ configuration.nix
#   └─ ./modules
#       └─ ./programs
#           ├─ default.nix *
#           └─ ...
#

[
  ./alacritty.nix
  ./eww.nix
  ./flatpak.nix
  ./rofi.nix
  ./waybar.nix
  ./wofi.nix
  ./vscode.nix
  ./timers.nix
  ./firejail.nix
  ./nix-ld.nix
  ./packages.nix
  ./command_not_found.nix
  ./nix_alien.nix
  #./opensnitch.nix
  #./games.nix
]
