
# Connect to vmware variables
$Server = "end-epvc01.next-uk.next.loc"
$creds = Get-StoredCredential -Target 'next'
#Set-PowerCLIConfiguration -InvalidCertificateAction "ignore"

# Cluster variables
$cluster = "end-epvh19-cluster"

# DRS variables
$list = Get-Content "C:\CSV\edas_vms_list.txt"
$enderby_dev_drs_rule = "Enderby DEV/UAT VMs"
$gedding_dev_drs_rule = "Gedding DEV/UAT VMs"


#Connect-VIServer -Server $Server -Protocol https -Credential $creds
    # Will prompt for DUO


    foreach ($vm in $list) {
   

    #Gedding Affinity Rules

        if ( $vm.endswith("0") ) { Write-Host "Adding $vm to $gedding_dev_drs_rule" -ForegroundColor Green}
        
                                       # Set-DrsClusterGroup $gedding_dev_drs_rule -VM $vm -Add }


        if ( $vm.endswith("2") ) { Write-Host "Adding $vm to $gedding_dev_drs_rule" -ForegroundColor Green}
        
                                        #Set-DrsClusterGroup $gedding_dev_drs_rule -VM $vm -Add }


        if ( $vm.endswith("4") ) { Write-Host "Adding $vm to $gedding_dev_drs_rule" -ForegroundColor Green}
        
                                        #Set-DrsClusterGroup $gedding_dev_drs_rule -VM $vm -Add }

    
        if ( $vm.endswith("6") ) { Write-Host "Adding $vm to $gedding_dev_drs_rule" -ForegroundColor Green}
        
                                        #Set-DrsClusterGroup $gedding_dev_drs_rule -VM $vm -Add }


        if ( $vm.endswith("8") ) { Write-Host "Adding $vm to $gedding_dev_drs_rule" -ForegroundColor Green}
        
                                        #Set-DrsClusterGroup $gedding_dev_drs_rule -VM $vm -Add }


    
            $get_vm_details = Get-VM -name $vm | Select Name, VMHost, PowerState
            $get_drs_group_details = Get-DrsClusterGroup -Type VMGroup -Name $enderby_dev_drs_rule


                  $drs_object = New-Object PSObject -Property @{ 
     
                                GroupName      = $get_drs_group_details.Name
                                VmName         = $get_vm_details.Name
                                VmHost         = $get_vm_details.PowerState
                                VmPowerState   = $get_vm_details.PowerState
                                Cluster        = $get_drs_group_details.Cluster
     
                                } $drs_object| FT VmName, GroupName,VmHost, VmPowerState, Cluster


    
    #Enderby Affinity Rules

        if ( $vm.endswith("1") ) { Write-Host "Adding $vm to $enderby_dev_drs_rule" -ForegroundColor Green}
        
                                    #    Set-DrsClusterGroup $enderby_dev_drs_rule -VM $vm -Add }


        if ( $vm.endswith("3") ) { Write-Host "Adding $vm to $enderby_dev_drs_rule" -ForegroundColor Green}
        
                                    #    Set-DrsClusterGroup $enderby_dev_drs_rule -VM $vm -Add }


        if ( $vm.endswith("5") ) { Write-Host "Adding $vm to $enderby_dev_drs_rule" -ForegroundColor Green}
        
                                    #    Set-DrsClusterGroup $enderby_dev_drs_rule -VM $vm -Add }


        if ( $vm.endswith("7") ) { Write-Host "Adding $vm to $enderby_dev_drs_rule" -ForegroundColor Green}
        
                                    #    Set-DrsClusterGroup $enderby_dev_drs_rule -VM $vm -Add }


        if ( $vm.endswith("9") ) { Write-Host "Adding $vm to $enderby_dev_drs_rule" -ForegroundColor Green }
        
                                   #     Set-DrsClusterGroup $enderby_dev_drs_rule -VM $vm -Add}


}


    foreach ( $vm in $list) {


            $get_vm_details = Get-VM -name $vm | Select Name, VMHost, PowerState 
            $get_drs_group_details = Get-DrsClusterGroup -Type VMGroup -Name $enderby_dev_drs_rule 
            $get_ged_drs_group_details = Get-DrsClusterGroup -Type VMGroup -Name $gedding_dev_drs_rule

                  $drs_object = New-Object object -Property @{ 
     
                                GroupName      = $get_drs_group_details.Name
                                VmName         = $get_vm_details.Name
                                VmHost         = $get_vm_details.VMHost
                                VmPowerState   = $get_vm_details.PowerState
                                Cluster        = $get_drs_group_details.Cluster
     
                                } 
                                
                                $drs_object | Format-List #| Out-File C:\CSV\drs_output.txt -Append

    }


    foreach ( $vm in $list) {

    $get_vm_details = Get-VM -name $vm | Select Name, VMHost, PowerState 
            $get_drs_group_details = Get-DrsClusterGroup -Type VMGroup -Name $enderby_dev_drs_rule 
            $get_ged_drs_group_details = Get-DrsClusterGroup -Type VMGroup -Name $gedding_dev_drs_rule



    $employees = @(
                    [pscustomobject]@{ VmName = $get_vm_details.Name ; GroupName = $get_drs_group_details.Name ; VmHost = $get_vm_details.VMHost ; VmPowerState = $get_vm_details.PowerState ; Cluster = $get_drs_group_details.Cluster}
                    
                    ) 
                    
                    $employees | ft  #| Out-File C:\CSV\drs_output.txt -Append


}


## add write-host to each if to know what its doing
## add get at the end for readable confirmation that vm's have been added
## will migrate vm's immediately when rule is applied - do in small batches to avoid overloading vmware