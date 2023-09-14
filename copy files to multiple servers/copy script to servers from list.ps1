
# Variable for the csv containing the list of server names you are copying too

$list = Import-Csv "C:\temp\copy_list.csv"



    Foreach ($Server in $list) {

    #Set variables for Destination files
    $Name = $Server.Name
    $file_1 = "C:\SCRIPTS\!NEXT_SCRIPTS\Get DNS settings\copy_scripts\change_dns_priority.ps1"
    $file_2 = "C:\SCRIPTS\!NEXT_SCRIPTS\Get DNS settings\copy_scripts\list_address_and_index.ps1"
    
    
    $Destination = "\\" + $Name + "\c$\Installs\dns_demotion"




                          
            # Copies files and writes-host as it copies for each server in the list

                Write-Host Copying file_1 to $Destination -ForegroundColor Green
                
                   xcopy $file_1 $Destination\ /I/E/Y


                Write-Host Copying file_2 to $Destination -ForegroundColor Cyan

                   xcopy $file_2 $Destination\ /I/E/Y


   }
