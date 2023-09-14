
# Import powershell script to run custom commands
    Import-Module C:\SCRIPTS\!NEXT_SCRIPTS\Jita\bulk_jita_next.ps1


    #Set local server name as variable
        $servers = Get-Content C:\SCRIPTS\!NEXT_SCRIPTS\Jita\servers_names.txt


        foreach ($server in $servers) {
        
                    
                #Persistent accounts
            Write-Host "Setting persistent accounts on $server..." -ForegroundColor Green
            
                persist "NEXT-PLC\USRS-SVC-SupportLevel1" -computer_name $server -force
            
                persist "NEXT-PLC\USRS-ICE SVC Accounts" -computer_name $server -force

                persist "NEXT-PLC\SVC-PSTEPROD-GRP" -computer_name $server -force

                persist "NEXT-PLC\SVC-Orchestrator-DB" -computer_name $server -force
            
            
            
          #Unpersistent accounts
            Write-Host "Setting unpersistent accounts on $server..." -ForegroundColor Cyan
            
                unpersist "NEXT-PLC\USRS-ICE Support" -computer_name $server -force

                unpersist "NEXT-PLC\USRS-SupportLevel1" -computer_name $server -force

                unpersist "NEXT-PLC\USRS-Deployments" -computer_name $server -force
        
        
        
        
        
        
        
        }


          