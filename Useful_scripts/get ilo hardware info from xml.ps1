$iLOIP = "192.168.133.15","192.168.133.16","192.168.133.133","192.168.133.142"

#get info from xml
#unable to browse to xml for our ilo's
#script doesn't work for this reason, but still cool.
# https://deploymentbunny.com/2013/12/18/nice-to-know-getting-hardware-infoilo-data-using-native-powershell-and-no-need-for-credentials/

Function GetiLOData {
    foreach ($IP in $ILOIP){
    $XML = New-Object XML
    $HostName = Resolve-DnsName -Name $IP
    $XML.Load("http://$IP/xmldata?item=All")
    New-Object PSObject -Property @{
      iLOName = $($HostName.NameHost);
      iLOIP = $($IP);
      ServerType = $($XML.RIMP.HSI.SPN);
      ProductID = $($XML.RIMP.HSI.PRODUCTID);
      UUID = $($XML.RIMP.HSI.cUUID);
      Nic01 = $($XML.RIMP.HSI.NICS.NIC[0].MACADDR);
      Nic02 = $($XML.RIMP.HSI.NICS.NIC[1].MACADDR);
      ILOType = $($XML.RIMP.MP.PN);
      iLOFirmware = $($XML.RIMP.MP.FWRI)
    }
}
}

GetiLOData | Select iLOName,iLOIP,ServerType,ProductID,Nic01,Nic02,UUID,iLOType,iLOFirmware | Out-GridView