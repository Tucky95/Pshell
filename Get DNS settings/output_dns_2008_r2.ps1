
$hostname = $env:computername

$output = $hostname + "_dmz_dns_servers.txt"


$dns = cmd.exe /c netsh interface ipv4 show dns | Out-File c:\installs\$output

exit