<#

Script for 2016 & 12 servers

Change values on :
    - Line 16
    - Line 25
    - Line 36
    - Line 39
    - Line 57
#> 


$ErrorActionPreference = "Continue"

$servers = Get-content "C:\CSV\dc12_test_list.txt"
# txt file with list of server names that will run the dns script from


    foreach ($server in $servers){


        Write-host "Running psexec on $server" -ForegroundColor Green

        C:\PSTOOLS\PsExec.exe "\\$server" -h -d powershell.exe -File "C:\Installs\dns_script\dns_demotion\list_address_and_index.ps1" -nobanner

     }


# Pause for 3 mins to ensure service stops and deletes
    Write-Host "Waiting for 15 seconds" -ForegroundColor Cyan
        
        Start-Sleep -seconds 15


$CSV = import-csv "C:\CSV\dc12_test_list.csv"
# csv file that the compiled list of DNS files will be created from

$output_location = "C:\CSV\dc12_test_compiled_dns.csv"
# file that will be created with all server dns settings. Opens file at the end of the script. Line 40

        $CSV | ForEach-Object { 

            $name = $_.Name
            $file = "dns_test.csv"
            $path = "\\" + $name + "\c$\CSV\" + $file

            $get = Get-Content $path 
    
            Write-Host "Compiling DNS settings for server $name" -ForegroundColor Green
            $get |  Out-File $output_location -Append
    

}

# Opens compiled list at the end of the script. Change this location to match $output_location
    #C:\CSV\non_linux_08_compiled_dns.txt