
$hostname = $env:computername

$output = $hostname + "_dmz_dns_servers.txt"


Get-DnsClientServerAddress -InterfaceAlias "ice dmz*" | Select-Object -ExpandProperty ServerAddresses | Out-File c:\installs\$output