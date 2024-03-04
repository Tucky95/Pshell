
# Connect to vmware variables
$Server = "end-epvc01.next-uk.next.loc"
$creds = Get-StoredCredential -Target 'next'
#Set-PowerCLIConfiguration -InvalidCertificateAction "ignore"

# Cluster variables
$cluster = "end-epvh19-cluster"

# DRS variables
$list = Get-Content "C:\CSV\test_drs_list.txt"
$enderby_dev_drs_rule = "Enderby DEV/UAT VMs"
$gedding_dev_drs_rule = "Gedding DEV/UAT VMs"

# VM Tag variables
$enderby_vm_tag = "VM_Tag_Enderby"
$gedding_vm_tag = "VM_Tag_Gedding"

# Membership report variable
$output = "C:\CSV\drs_report.txt"


         ################## Unhash the below to connect to vmware ############

        #Connect-VIServer -Server $Server -Protocol https -Credential $creds
            
        ##################### Will prompt for DUO ###########################


    foreach ($vm in $list) {
   

    #Gedding Affinity Rules

        if ( $vm.endswith("0") ) { Write-Host "Adding $vm to $gedding_dev_drs_rule" -ForegroundColor Green
        
                                       Set-DrsClusterGroup $gedding_dev_drs_rule -VM $vm -Add | Out-Null
                                           #Add server to the DRS group for Gedding servers
                                       
                                    Write-Host " Assigning $gedding_vm_tag to $vm " -ForegroundColor Blue -BackgroundColor White
                                       
                                       New-TagAssignment -Entity $vm -Tag $gedding_vm_tag | Out-Null
                                           #Add tag to server to label it as a Gedding server
                                           }

        
        if ( $vm.endswith("2") ) { Write-Host "Adding $vm to $gedding_dev_drs_rule" -ForegroundColor Green
        
                                        Set-DrsClusterGroup $gedding_dev_drs_rule -VM $vm -Add | Out-Null
                                            #Add server to the DRS group for Gedding servers

                                    Write-Host " Assigning $gedding_vm_tag to $vm " -ForegroundColor Blue -BackgroundColor White
                                        
                                        New-TagAssignment -Entity $vm -Tag $gedding_vm_tag | Out-Null
                                           #Add tag to server to label it as a Gedding server
                                           }

        
        if ( $vm.endswith("4") ) { Write-Host "Adding $vm to $gedding_dev_drs_rule" -ForegroundColor Green
        
                                        Set-DrsClusterGroup $gedding_dev_drs_rule -VM $vm -Add | Out-Null
                                            #Add server to the DRS group for Gedding servers

                                     Write-Host " Assigning $gedding_vm_tag to $vm " -ForegroundColor Blue -BackgroundColor White
                                        
                                        New-TagAssignment -Entity $vm -Tag $gedding_vm_tag | Out-Null
                                           #Add tag to server to label it as a Gedding server
                                           }

    
        if ( $vm.endswith("6") ) { Write-Host "Adding $vm to $gedding_dev_drs_rule" -ForegroundColor Green
        
                                        Set-DrsClusterGroup $gedding_dev_drs_rule -VM $vm -Add | Out-Null
                                            #Add server to the DRS group for Gedding servers

                                     Write-Host " Assigning $gedding_vm_tag to $vm " -ForegroundColor Blue -BackgroundColor White
                                        
                                        New-TagAssignment -Entity $vm -Tag $gedding_vm_tag | Out-Null
                                           #Add tag to server to label it as a Gedding server
                                           }


        if ( $vm.endswith("8") ) { Write-Host "Adding $vm to $gedding_dev_drs_rule" -ForegroundColor Green
        
                                        Set-DrsClusterGroup $gedding_dev_drs_rule -VM $vm -Add | Out-Null
                                            #Add server to the DRS group for Gedding servers

                                    Write-Host " Assigning $gedding_vm_tag to $vm " -ForegroundColor Blue -BackgroundColor White
                                        
                                        New-TagAssignment -Entity $vm -Tag $gedding_vm_tag | Out-Null
                                           #Add tag to server to label it as a Gedding server
                                           }

    
   
  
    #Enderby Affinity Rules


        if ( $vm.endswith("1") ) { Write-Host "Adding $vm to $enderby_dev_drs_rule" -ForegroundColor Green
        
                                        Set-DrsClusterGroup $enderby_dev_drs_rule -VM $vm -Add | Out-Null
                                            #Add server to the DRS group for Gedding servers

                                     Write-Host " Assigning $enderby_vm_tag to $vm " -ForegroundColor Blue -BackgroundColor White

                                        New-TagAssignment -Entity $vm -Tag $enderby_vm_tag | Out-Null
                                           #Add tag to server to label it as a Gedding server
                                           }


        if ( $vm.endswith("3") ) { Write-Host "Adding $vm to $enderby_dev_drs_rule" -ForegroundColor Green
        
                                        Set-DrsClusterGroup $enderby_dev_drs_rule -VM $vm -Add | Out-Null
                                            #Add server to the DRS group for Gedding servers

                                     Write-Host " Assigning $enderby_vm_tag to $vm " -ForegroundColor Blue -BackgroundColor White

                                        New-TagAssignment -Entity $vm -Tag $enderby_vm_tag | Out-Null
                                           #Add tag to server to label it as a Gedding server
                                           }


        if ( $vm.endswith("5") ) { Write-Host "Adding $vm to $enderby_dev_drs_rule" -ForegroundColor Green
        
                                        Set-DrsClusterGroup $enderby_dev_drs_rule -VM $vm -Add | Out-Null
                                            #Add server to the DRS group for Gedding servers

                                    Write-Host " Assigning $enderby_vm_tag to $vm " -ForegroundColor Blue -BackgroundColor White

                                        New-TagAssignment -Entity $vm -Tag $enderby_vm_tag | Out-Null
                                           #Add tag to server to label it as a Gedding server
                                           }


        if ( $vm.endswith("7") ) { Write-Host "Adding $vm to $enderby_dev_drs_rule" -ForegroundColor Green
        
                                        Set-DrsClusterGroup $enderby_dev_drs_rule -VM $vm -Add | Out-Null
                                            #Add server to the DRS group for Gedding servers

                                    Write-Host " Assigning $enderby_vm_tag to $vm " -ForegroundColor Blue -BackgroundColor White

                                        New-TagAssignment -Entity $vm -Tag $enderby_vm_tag | Out-Null
                                           #Add tag to server to label it as a Gedding server
                                           }


        if ( $vm.endswith("9") ) { Write-Host "Adding $vm to $enderby_dev_drs_rule" -ForegroundColor Green 
        
                                        Set-DrsClusterGroup $enderby_dev_drs_rule -VM $vm -Add | Out-Null
                                            #Add server to the DRS group for Gedding servers
                                            
                                    Write-Host " Assigning $enderby_vm_tag to $vm " -ForegroundColor Blue -BackgroundColor White

                                        New-TagAssignment -Entity $vm -Tag $enderby_vm_tag | Out-Null
                                           #Add tag to server to label it as a Gedding server
                                           }

    }


# Variables for generating report of DRS group members
    $get_ged_drs_group_details = Get-DrsClusterGroup -Type VMGroup -Name $gedding_dev_drs_rule
    $get_end_drs_group_details = Get-DrsClusterGroup -Type VMGroup -Name $enderby_dev_drs_rule


        Write-Host "
            DRS rules changes complete                         
                                                               
            Getting all DRS Rule members....                   
                                                               
            Report will be saved to $output      " -ForegroundColor DarkBlue -BackgroundColor White            
                # Progress prompt, details when report is being generated & where it will be saved



# Foreach loop that generates a list of all members of the Gedding affinty rule group
        
    Foreach ($ged_vm in $get_ged_drs_group_details) {

                $get_ged_vm_deets = Get-VM -Name $get_ged_drs_group_details.Member | Select Name , VMHost, PowerState

                    $ged_report = foreach ( $thing1 in $get_ged_vm_deets ) { 

                        $get_ged_tag = Get-TagAssignment -Entity $thing1.Name
        
                        @( [pscustomobject]@{ VmName = $thing1.Name ; DRSGroup = $get_ged_drs_group_details.Name ; VmHost = $thing1.VMHost ; PowerState = $thing1.PowerState ; VmTag = $get_ged_tag.Tag } )

                                                } 
        } 

         


# Foreach loop that generates a list of all members of the Enderby affinty rule group
        
    Foreach ($end_vm in $get_end_drs_group_details) {

                $get_end_vm_deets = Get-VM -Name $get_end_drs_group_details.Member | Select Name , VMHost, PowerState
                

                    $end_report = foreach ( $thing in $get_end_vm_deets ) { 

                        $get_end_tag = Get-TagAssignment -Entity $thing.Name
        
                        @( [pscustomobject]@{ VmName = $thing.Name ; DRSGroup = $get_end_drs_group_details.Name ; VmHost = $thing.VMHost ; PowerState = $thing.PowerState ; VmTag = $get_end_tag.Tag } )

                                                } 
        } 




    # Saves the list of members to the location specified in $ouput. Line 20. Will save the members of both groups in the same file
        
        $ged_report | FT -AutoSize | Out-File $output
        $end_report | FT -AutoSize | Out-File $output -Append

        C:\CSV\drs_report.txt 


        #### Need to add a get at beginning of the script for comparison 