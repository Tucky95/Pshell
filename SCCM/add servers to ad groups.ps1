
## RUN THIS ON END-EDAS100! ##


$AD_Group = "COMP-RunBook-Patching,COMP-Servers-DisableLLMNR,COMP-WSUS-SCCM,eComm_Gold_AD"
$Server_Name = "END-ESWS6101"
#,END-EPWS6110,END-EPWS6111,END-EPWS6112,END-EPWS6113,END-EPWS6115,END-EPWS6116,END-EPWS6117

Get-ADComputer -Filter $Server_Name -Properties Name, OperatingSystem, OperatingSystemVersion -SearchBase "OU=Web Servers,OU=Live,OU=Servers,OU=eCommerceDMZ,DC=dmz,DC=next-uk,DC=next,DC=loc" | Format-Table Name, OperatingSystem, OperatingSystemVersion

Get-ADComputer -Filter -

CN=END-ESWS6101,OU=Web Servers,OU=Live,OU=Servers,OU=eCommerceDMZ,DC=dmz,DC=next-uk,DC=next,DC=loc

Get-ADComputer -

    Add-ADGroupMember -Identity $AD_Group -Members $Server_Name