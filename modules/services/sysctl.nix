#
# Sysctl - setup kernel parameters 
#

{ config, lib, pkgs, ... }:

{  
  boot = {
    kernel = {
      sysctl = {# for info: https://wiki.archlinux.org/title/Sysctl
        "net.core.netdev_max_backlog" = 16384; # Increasing this value for high speed cards may help prevent losing packets
        "net.ipv4.tcp_fastopen" = 3; # TCP Fast Open
        "vm.nr_hugepages" = 0;       # allocate hugepages
        "vm.nr_overcommit_hugepages" = 1048576; # 1GiB  or # 2048 = 2MiB
        "net.ipv4.tcp_syncookies" = false; 
        "vm.swappiness" = 60; 
      };
    };
  };
}
