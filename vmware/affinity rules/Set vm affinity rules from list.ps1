
# Connect to vmware variables
$Server = "end-epvc01.next-uk.next.loc"
$username = "administrator@vsphere.local"
$pw = "Wibble123!"
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

        if ( $vm.endswith("0") ) { Set-DrsClusterGroup $gedding_dev_drs_rule -VM $vm -Add }

        if ( $vm.endswith("2") ) { Set-DrsClusterGroup $gedding_dev_drs_rule -VM $vm -Add }

        if ( $vm.endswith("4") ) { Set-DrsClusterGroup $gedding_dev_drs_rule -VM $vm -Add }
    
        if ( $vm.endswith("6") ) { Set-DrsClusterGroup $gedding_dev_drs_rule -VM $vm -Add }

        if ( $vm.endswith("8") ) { Set-DrsClusterGroup $gedding_dev_drs_rule -VM $vm -Add }

    #Enderby Affinity Rules

        if ( $vm.endswith("1") ) { Set-DrsClusterGroup $enderby_dev_drs_rule -VM $vm -Add }

        if ( $vm.endswith("3") ) { Set-DrsClusterGroup $enderby_dev_drs_rule -VM $vm -Add }

        if ( $vm.endswith("5") ) { Set-DrsClusterGroup $enderby_dev_drs_rule -VM $vm -Add }

        if ( $vm.endswith("7") ) { Set-DrsClusterGroup $enderby_dev_drs_rule -VM $vm -Add }

        if ( $vm.endswith("9") ) { Set-DrsClusterGroup $enderby_dev_drs_rule -VM $vm -Add }


}


## add write-host to each if to know what its doing
## add get at the end for readable confirmation that vm's have been added
## will migrate vm's immediately when rule is applied - do in small batches to avoid overloading vmware