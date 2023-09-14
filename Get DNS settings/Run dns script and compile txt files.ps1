<#

Script for 2016 & 12 servers

Change values on :
    - Line 16
    - Line 25
    - Line 31
    - Line 34
    - Line 52
#> 


$ErrorActionPreference = "Continue"

$servers = Get-content "C:\CSV\non_linux_08_dmz_servers.txt"
# txt file with list of server names that will run the dns script from


    foreach ($server in $servers)
    {

        Write-host "Running psexec on $server" -ForegroundColor Green

        C:\PSTOOLS\PSexec.exe \\$server -h -d powershell.exe -File "C:\Installs\dns_script\output_dns_settings.ps1"

     }



$CSV = import-csv "C:\CSV\non_linux_08_dmz_servers.csv"
# csv file that the compiled list of DNS files will be created from

$output_location = "C:\CSV\non_linux_08_compiled_dns.txt"
# file that will be created with all server dns settings. Opens file at the end of the script. Line 40

        $CSV | ForEach-Object { 

            $name = $_.Name
            $file = $name + "_dmz_dns_servers.txt"
            $path = "\\" + $name + "\c$\installs\" + $file

            $get = Get-Content $path 
    
            Write-Host "Compiling DNS settings for server $name" -ForegroundColor Green
            $name + "|" + $get |  Out-File $output_location -Append
    

}

# Opens compiled list at the end of the script. Change this location to match $output_location
    C:\CSV\non_linux_08_compiled_dns.txt