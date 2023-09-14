# Import powershell script to run custom commands
    Import-Module C:\installs\PostBuildScript\eCommercePS\Jita\jita_ps_module_url_populated.ps1




    #Set local server name as variable
        $server_name = $env:computername

        $network_location = Read-Host 'Is the server hosted on DMZ or Corp'

            if ( $network_location -eq 'DMZ' ) { 
            
                $DMZ_name = $server_name + '.dmz.next-uk.next.loc' 
                
                
                #Persistent accounts
            Write-Host "Setting persistent accounts..." -ForegroundColor Green
            
                persist "NEXT-PLC\USRS-SVC-SupportLevel1" -computer_name $DMZ_name -force
            
                persist "NEXT-PLC\USRS-ICE SVC Accounts" -computer_name $DMZ_name -force

                persist "NEXT-PLC\SVC-PSTEPROD-GRP" -computer_name $DMZ_name -force

                persist "NEXT-PLC\SVC-Orchestrator-DB" -computer_name $DMZ_name -force
            
            
            
          #Unpersistent accounts
            Write-Host "Setting unpersistent accounts..." -ForegroundColor Cyan
            
                unpersist "NEXT-PLC\USRS-ICE Support" -computer_name $DMZ_name -force

                unpersist "NEXT-PLC\USRS-SupportLevel1" -computer_name $DMZ_name -force

                unpersist "NEXT-PLC\USRS-Deployments" -computer_name $DMZ_name -force
                
                
                
                              
                
}

            elseif ( $network_location -eq 'Corp' ) { 
            
                    $Corp_name = $server_name + '.next-uk.next.loc' 
                    
                    
                      #Persistent accounts
            Write-Host "Setting persistent accounts..." -ForegroundColor Green
            
                persist "NEXT-PLC\USRS-SVC-SupportLevel1" -computer_name $Corp_name -force
            
                persist "NEXT-PLC\USRS-ICE SVC Accounts" -computer_name $Corp_name -force

                persist "NEXT-PLC\SVC-PSTEPROD-GRP" -computer_name $Corp_name -force

                persist "NEXT-PLC\SVC-Orchestrator-DB" -computer_name $Corp_name -force
            
            
            
          #Unpersistent accounts
            Write-Host "Setting unpersistent accounts..." -ForegroundColor Cyan
            
                unpersist "NEXT-PLC\USRS-ICE Support" -computer_name $Corp_name -force

                unpersist "NEXT-PLC\USRS-SupportLevel1" -computer_name $Corp_name -force

                unpersist "NEXT-PLC\USRS-Deployments" -computer_name $Corp_name -force
                    
                    
                    
                                  
                    
} 