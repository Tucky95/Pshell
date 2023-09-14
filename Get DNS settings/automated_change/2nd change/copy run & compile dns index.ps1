
$ErrorActionPreference = "Continue"


# Variable for the csv containing the list of server names you are copying too

    # List of server names the script will read from
        $CSV = Import-Csv "C:\CSV\2nd DNS Change.csv"
    
    # Name and location of generated csv containing all server info
        $output_location = "C:\CSV\dns_change2_compiled.csv"



# Line 17-36 will copy the script to every server in $CSV
        
        Foreach ($Server in $CSV) {

    #Set variables for Destination files
    $Name = $Server.Name
    $file_1 = "C:\SCRIPTS\!NEXT_SCRIPTS\Get DNS settings\automated_change\copy_scripts\list_address_and_index.ps1"
        
    
    $Destination = "\\" + $Name + "\c$\Installs\dns_script\dns_demotion"


                          
            # Copies files and writes-host as it copies for each server in the list

                Write-Host Copying file_1 to $Destination -ForegroundColor Green
                
                   xcopy $file_1 $Destination\ /I/E/Y


              
   }


# Line 41-52 will use psexec.exe (needs to be locally installed) to execute the copied script locally on every server in $CSV

        $CSV | ForEach-Object { 

            $name = "\\"  + $_.Name
           

      Write-host "Running list_address_and_index script locally on $name" -ForegroundColor Green
     
     C:\PSTOOLS\PsExec.exe $name -h -d powershell.exe -File "C:\Installs\dns_script\dns_demotion\list_address_and_index.ps1" -nobanner



}


# Pause for 15 seconds to ensure all scripts have finished exporting to csv before compiling
    Write-Host "Waiting for 15 seconds" -ForegroundColor Cyan
        
        Start-Sleep -seconds 15


# Line 63-75 will generate 1 csv containing info gathered from all servers in above section

        $CSV | ForEach-Object { 

            $name = $_.Name
            $file = "dns_index_output.csv"
            $path = "\\" + $name + "\c$\installs\dns_script\dns_demotion\" + $file

            $get = Get-Content $path 
    
            Write-Host "Compiling DNS settings for server $name" -ForegroundColor Green
            $get |  Out-File $output_location -Append
    

}



# Opens compiled list at the end of the script. Change this location to match $output_location
          Invoke-item $output_location