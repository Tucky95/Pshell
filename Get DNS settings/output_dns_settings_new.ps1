
$hostname = $env:computername

$output = $hostname + "_dmz_dns_servers.txt"


Get-DnsClientServerAddress | Select-Object -ExpandProperty ServerAddresses | Out-File c:\installs\$output