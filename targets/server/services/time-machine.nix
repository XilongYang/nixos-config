{ ... }:

{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "server min protocol" = "SMB2";
        "server smb encrypt" = "desired";
        "vfs objects" = "catia fruit streams_xattr";
        "fruit:aapl" = "yes";
        "fruit:nfs_aces" = "no";
        "fruit:metadata" = "stream";
        "fruit:resource" = "file";
      };

      TimeMachine = {
        path = "/data/apple/time-machine";
        "read only" = "no";
        "valid users" = "xilong";
        "force user" = "root";
        "fruit:time machine" = "yes";
        "fruit:time machine max size" = "1000 G";
      };
    };
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      userServices = true;
    };
    extraServiceFiles.timemachine = ''
      <?xml version="1.0" standalone='no'?>
      <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
      <service-group>
        <name replace-wildcards="yes">%h</name>
        <service>
          <type>_smb._tcp</type>
          <port>445</port>
        </service>
        <service>
          <type>_device-info._tcp</type>
          <port>0</port>
          <txt-record>model=RackMac</txt-record>
        </service>
        <service>
          <type>_adisk._tcp</type>
          <port>9</port>
          <txt-record>sys=waMA=0,adVF=0x100</txt-record>
          <txt-record>dk0=adVN=TimeMachine,adVF=0x82</txt-record>
        </service>
      </service-group>
    '';
  };

  networking.firewall.allowedTCPPorts = [ 445 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];
}
