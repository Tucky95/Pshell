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


$CSV = import-csv "C:\CSV\full_list_p2.csv"
# csv file that the compiled list of DNS files will be created from


        $CSV | ForEach-Object { 

            $name = "\\"  + $_.Name
           

      Write-host "Running psexec on $name" -ForegroundColor Green
     
     C:\PSTOOLS\PsExec.exe $name -h -d powershell.exe -File "C:\Installs\dns_script\dns_demotion\list_address_and_index.ps1" -nobanner



}


# Pause for 3 mins to ensure service stops and deletes
    Write-Host "Waiting for 15 seconds" -ForegroundColor Cyan
        
        Start-Sleep -seconds 15


$output_location = "C:\CSV\16_19_missed_compiled_dns_part2.csv"
# file that will be created with all server dns settings. Opens file at the end of the script. Line 40

        $CSV | ForEach-Object { 

            $name = $_.Name
            $file = "dns_index_output.csv"
            $path = "\\" + $name + "\c$\installs\dns_script\dns_demotion\" + $file

            $get = Get-Content $path 
    
            Write-Host "Compiling DNS settings for server $name" -ForegroundColor Green
            $get |  Out-File $output_location -Append
    

}

# Opens compiled list at the end of the script. Change this location to match $output_location
     #C:\CSV\16_19_missed_compiled_dns_part1.csv
        
        $output_location