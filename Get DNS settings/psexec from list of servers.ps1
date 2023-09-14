$ErrorActionPreference = "Continue"

$servers = Get-content "C:\CSV\test_list.txt"

foreach ($server in $servers)
{

Write-host "Running psexec on $server" -ForegroundColor Green

    C:\PSTOOLS\PSexec.exe \\$server -h -d powershell.exe -File "C:\Installs\dns_script\output_dns_settings.ps1"

}


#.\psexec \\end-epas107 -s Powershell -WindowStyle Hidden -File C:\Installs\dns_script\output_dns_settings.ps1

#C:\PSTOOLS\PSexec.exe \\$server -h -d powershell.exe -File "C:\Installs\dns_script\output_dns_settings_new.ps1"