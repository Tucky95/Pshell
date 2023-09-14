$ErrorActionPreference = "Continue"

$servers = Get-content "C:\temp\2008_dmz_2.txt"

foreach ($server in $servers)
{

Write-host "Running psexec on $server - 2008" -ForegroundColor Cyan

    C:\PSTOOLS\PSexec.exe \\$server -h -d powershell.exe -File "C:\Installs\dns_script\output_dns_2008_r2.ps1"

}


