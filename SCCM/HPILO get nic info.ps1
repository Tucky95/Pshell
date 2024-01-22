Import-Module HpeIloCmdlets


$credential = Get-Credential
$Server =  "172.28.51.146"

$esxi = Connect-HPEiLO -IP $Server -Credential $credential -DisableCertificateAuthentication

Get-HPEiLOFirmwareInventory -Connection $esxi



Get-HPiLONICInfo -Server $Server -Credential $credential -DisableCertificateAuthentication | Out-File C:\temp\mac_info.txt
    #Use this command for nic info




Get-HPiLONetworkSetting -Server $Server -Credential $credential -DisableCertificateAuthentication

Get-HPOAServerInfo -Server $Server -Credential $credential -DisableCertificateAuthentication

Get-HPEiLOIPv4NetworkSetting -Connection $esxi


Get-HPEiLOServerInfo -Connection $esxi

Get-HPEiLOProfile -Connection $esxi

Get-HPEiLOSecureBoot -Connection $esxi



get-help Get-HPiLONICInfo -Examples


Disconnect-HPEiLO