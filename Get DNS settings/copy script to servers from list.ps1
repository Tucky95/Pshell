#$servers = get-content "C:\SCRIPTS\!NEXT_SCRIPTS\prod_servers.txt"


$test_list = Import-Csv "C:\temp\leftovers.csv"



    Foreach ($Server in $test_list) {

    #Set variables for Destination files
    $Name = $Server.Name
    $installer = "C:\temp\dns_script\output_dns_settings_new.ps1"
    
    
    $Destination = "\\" + $Name + "\c$\Installs"




                          
            
                Write-Host Copying script to $Destination -ForegroundColor Green
                
                #New-Item -ItemType "directory" -Path "$Destination\NetBackup_8.1.2_Win"

                    xcopy $installer $Destination\dns_script\ /I/E/Y


   }
