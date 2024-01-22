
# Copy this script to server and run locally
## Run as admin
### Run this script manually. ONLY run this after both NIC's have been enabled in VCEM ##

<# 

Colour Code:
    
    DarkCyan      = Search
    Red + White   = Error with process
    Green         = Success with process 
    Yellow        = Script waiting
    Magenta       = Action with no output
    
#>

## Disable unused NIC's ##

Write-Host "Disabling all disconnected Nic's..." -ForegroundColor Green

    Get-NetAdapter | select Name, InterfaceDescription, ifIndex, Status, MacAddress, LinkSpeed | where { $_.Status -ne 'up' -or $_.LinkSpeed -ne '10 Gbps' } | Disable-NetAdapter -Confirm:$false

 $enabled_nics = Get-NetAdapter | select Name, InterfaceDescription, ifIndex, Status, MacAddress, LinkSpeed | where { $_.Status -eq 'up' }
  
## Create NIC Team ##
   
Write-Host Creating NIC Team using $enabled_nics.Name -ForegroundColor Green
   
   New-NetLbfoTeam -Name "Team" -TeamMembers $enabled_nics.Name -Confirm:$false

 Write-Host "Waiting for 15 seconds while NIC Team is setup..." -ForegroundColor Yellow
 Start-Sleep -Seconds 15

    $team = Get-NetAdapter | select Name, ifIndex | where { $_.Name -eq 'Team' }
    $primary_ip = Read-Host "Enter Primary IP address here..."


## Setting static IP's ##

Write-Host Setting $primary_ip to $team.Name -ForegroundColor Magenta

    New-NetIPAddress -InterfaceIndex $team.ifIndex -IPAddress $primary_ip -AddressFamily IPv4 -PrefixLength 16 -DefaultGateway 101.10.10.3

 
## Set DNS settings ## 
 
$DNS_Servers = "172.28.65.39" , "172.28.65.37" , "172.28.64.26" , "172.28.64.25" | Get-Random -Count 4
$shuffled_dns = $DNS_Servers | Sort-Object {Get-Random}

 
Write-Host Setting $shuffled_dns to $team.Name -ForegroundColor Magenta
    
    Set-DnsClientServerAddress -InterfaceIndex $team.ifIndex -ServerAddresses $shuffled_dns

$secondary_ip_prompt = Read-Host "Enter Secondary IP Address Here..."
$secondary_ip = $secondary_ip_prompt + '/16'

Write-Host Setting $secondary_ip to $team.Name -ForegroundColor Magenta

    .\netsh.exe int ipv4 add address $team.Name $secondary_ip skipassource=true

    .\netsh.exe int ipv4 show ipaddresses level=verbose


## Setting DNS Suffixes ##

Write-Host Adding DNS suffixes to $team.Name -ForegroundColor Green

        Set-DnsClientGlobalSetting -SuffixSearchList @("dmz.next-uk.next.loc", "next-uk.next.loc", "next.loc")


## Disable LMHOSTS lookup ##

Write-Host Disabling LMHOSTS lookup -ForegroundColor Green

    $DisableLMHosts_Class=Get-WmiObject -list Win32_NetworkAdapterConfiguration
    $DisableLMHosts_Class.EnableWINS($false,$false)


## Disable NetBIOS over TCP/IP ##

Write-Host Disabling NetBIOS over TCP/IP on $team.Name -ForegroundColor Green

    $NETBIOS_DISABLED=2

        Get-WmiObject Win32_NetworkAdapterConfiguration -filter "ipenabled = 'true'" | ForEach-Object { $_.SetTcpipNetbios($NETBIOS_DISABLED)}


## Reg fix for Duo on DMZ ##

write-Host "Adding DUO reg keys..." -ForegroundColor Green

    Reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Duo Security\DUOCredProv" /v HttpProxyHost /d 101.10.145.240 /t REG_SZ
    Reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Duo Security\DUOCredProv" /v HttpProxyPort /d 9090 /t REG_DWORD


## Check machine.config has updated and is correct ##

Write-Host "Copying config file to .Net folder..." -ForegroundColor Green

    Copy-Item -Path "C:\Installs\New Server Scripts\Source\.NET Config\machine.config" -Destination "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\machine.config" -Force

     
     
     
     Write-Host "   Reboot system after running script to ensure changes take affect   " -ForegroundColor Blue -BackgroundColor White