#
#  ClamAv - Antivirus
#

{
  services = {
    clamav = {
      daemon = {
        enable = true;
      };
      updater = {
        enable = true;
      };
    };
  };
}
