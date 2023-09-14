
# Variable for the csv containing the list of server names you are copying too

$list = Import-Csv "C:\temp\Launch_Darkly\uat_ld_servers.csv"



    Foreach ($Server in $list) {

    #Set variables for Destination files
    $Name = $Server.Name
    $exe = "C:\temp\Launch_Darkly\ld-relay.exe"
    $config = "C:\temp\Launch_Darkly\ld-relay_PROD.conf"
    $instuctions = 'C:\temp\Launch_Darkly\LaunchDarkly Relay Proxy Instructions.txt'
    
    
    $Destination = "\\" + $Name + "\c$\LaunchDarkly_Relay_Proxy"




                          
            # Copies files and writes-host as it copies for each server in the list

                Write-Host Copying $exe to $Destination -ForegroundColor Green
                
                   #xcopy $exe $Destination\ /I/E/Y


                Write-Host Copying $config to $Destination -ForegroundColor Cyan

                   #xcopy $config $Destination\ /I/E/Y

                Write-Host Copying $instuctions to $Destination -ForegroundColor Cyan

                   xcopy $instuctions $Destination\ /I/E/Y


   }
