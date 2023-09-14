
$interface = Import-Csv "C:\CSV\dns_interface.csv"
    # Import csv containing names and interface numbers

$index = $interface.'InterfaceIndex'
    # Set InterfaceIndex to a variable


$DNSAddresses = @(
  ([IPAddress]'172.28.64.25').IPAddressToString
  ([IPAddress]'172.28.65.37').IPAddressToString
  ([IPAddress]'172.28.65.39').IPAddressToString
  ([IPAddress]'172.28.64.26').IPAddressToString  
)
    # DNS priority variable

Set-DnsClientServerAddress -ServerAddresses $DNSAddresses -InterfaceIndex $index
    # Command to set the address using above variables


ipconfig.exe /flushdns
    # Flushes DNS after making changes


Get-NetIPConfiguration
    # Gets config again to confirm changes have gone through