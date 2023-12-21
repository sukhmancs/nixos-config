#
#  Network Shares
#

{ vars, ... }:

{
  services = {
    samba = {
      enable = true;
      securityType = "user";
      extraConfig = ''
        workgroup = WORKGROUP
        server string = smbnix
        netbios name = smbnix
        security = user 
        #max protocol = smb2
        # note: localhost is the ipv6 localhost ::1
        hosts allow = 192.168.122. 127.0.0.1 localhost
        hosts deny = 0.0.0.0/0
        guest account = nobody
        map to guest = bad user
        server signing = auto
        deadtime = 30
        use sendfile = yes
        min receivefile size = 16384
      '';
      shares = {                                # Set Password: $ smbpasswd -a <user>
        share = {
          path = "/home/${vars.user}/share";
          browseable = "yes";
          "guest ok" = "no";
          "read only" = "no";
        };
      };
      openFirewall = true;
    };
  };
}
