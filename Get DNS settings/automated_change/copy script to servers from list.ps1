
# Variable for the csv containing the list of server names you are copying too

$list = Import-Csv "C:\CSV\full_list_p2.csv"



    Foreach ($Server in $list) {

    #Set variables for Destination files
    $Name = $Server.Name
    $file_1 = "C:\SCRIPTS\!NEXT_SCRIPTS\Get DNS settings\automated_change\copy_scripts\list_address_and_index.ps1"
        
    
    $Destination = "\\" + $Name + "\c$\Installs\dns_script\dns_demotion"


                          
            # Copies files and writes-host as it copies for each server in the list

                Write-Host Copying file_1 to $Destination -ForegroundColor Green
                
                   xcopy $file_1 $Destination\ /I/E/Y


              
   }
