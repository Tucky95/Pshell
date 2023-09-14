
$interface = Import-Csv "C:\CSV\dns_interface.csv"
    # Import csv containing names and interface numbers

$index = $interface.'InterfaceIndex '
    # Set InterfaceIndex to a variable


$DNSAddresses = @(
  ([IPAddress]'8.8.8.8').IPAddressToString
  ([IPAddress]'8.8.4.4').IPAddressToString
  ([IPAddress]'127.0.0.1').IPAddressToString
  ([IPAddress]'208.67.222.222').IPAddressToString  
  ([IPAddress]'208.67.220.220').IPAddressToString
)
    # DNS priority variable

Set-DnsClientServerAddress -ServerAddresses $DNSAddresses -InterfaceIndex $index
    # Command to set the address using above variables


ipconfig.exe /flushdns
    # Flushes DNS after making changes


Get-NetIPConfiguration
    # Gets config again to confirm changes have gone through