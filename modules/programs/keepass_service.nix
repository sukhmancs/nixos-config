{ config, lib, pkgs, ... }:

{
    services.keepass = {                      # Keepass 
    enable = false;
    # disable updates
    # disallow exporting, printing and changing master key
    configData = ''
<?xml version="1.0" encoding="utf-8"?>
<Configuration xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <Application>
    <Start>
      <CheckForUpdate>false</CheckForUpdate>
      <CheckForUpdateConfigured>true</CheckForUpdateConfigured>
    </Start>
  </Application>
</Configuration>
    '';
#    configData = ''
#      <?xml version="1.0" encoding="utf-8"?>
#      <Configuration xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
#        <Application>
#          <Start>
#            <CheckForUpdate>false</CheckForUpdate>
#	   <CheckForUpdateConfigured>true</CheckForUpdateConfigured>
#	 </Start>   
#          <TriggerSystem>
#            <Enabled>true</Enabled>
#          </TriggerSystem>       
#        </Application>
#        <UI>
#          <UIFlags>32</UIFlags>
#        </UI>
#        <Security>
#          <Policy>
#            <Export>false</Export>
#            <Print>false</Print>
#            <ChangeMasterKey>false</ChangeMasterKey>
#            <Plugins>false</Plugins>
#          </Policy>
#        </Security>
#      </Configuration>
#    '';
  };
}
