#$servers = get-content "C:\SCRIPTS\!NEXT_SCRIPTS\prod_servers.txt"


$test_list = Import-Csv "C:\temp\test_servers.csv"



    Foreach ($Server in $test_list) {

    #Set variables for Destination files
    $Name = $Server.Name
    $installer = "C:\temp\NetBackup_8.1.2_Win"
    
    
    $Destination = "\\" + $Name + "\c$\Installs"




                          
            
                Write-Host Copying install folder to $Destination -ForegroundColor Green
                
                #New-Item -ItemType "directory" -Path "$Destination\NetBackup_8.1.2_Win"

                    xcopy $installer $Destination\NetBackup_8.1.2_Win /E/Y


   }
