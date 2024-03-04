
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
$enderby_vm_tag = "VM_Tag_Enderby"
$gedding_vm_tag = "VM_Tag_Gedding"


#Connect-VIServer -Server $Server -Protocol https -Credential $creds
    # Will prompt for DUO


    foreach ($vm in $list) {
   

    #Gedding Affinity Rules

        if ( $vm.endswith("0") ) { New-TagAssignment -Entity $vm -Tag $gedding_vm_tag }

        if ( $vm.endswith("2") ) { New-TagAssignment -Entity $vm -Tag $gedding_vm_tag }

        if ( $vm.endswith("4") ) { New-TagAssignment -Entity $vm -Tag $gedding_vm_tag }
    
        if ( $vm.endswith("6") ) { New-TagAssignment -Entity $vm -Tag $gedding_vm_tag }

        if ( $vm.endswith("8") ) { New-TagAssignment -Entity $vm -Tag $gedding_vm_tag }

    #Enderby Affinity Rules

        if ( $vm.endswith("1") ) { New-TagAssignment -Entity $vm -Tag $enderby_vm_tag }

        if ( $vm.endswith("3") ) { New-TagAssignment -Entity $vm -Tag $enderby_vm_tag }

        if ( $vm.endswith("5") ) { New-TagAssignment -Entity $vm -Tag $enderby_vm_tag }

        if ( $vm.endswith("7") ) { New-TagAssignment -Entity $vm -Tag $enderby_vm_tag }

        if ( $vm.endswith("9") ) { New-TagAssignment -Entity $vm -Tag $enderby_vm_tag }


}


## add write-host to each if to know what its doing
## add get at the end for readable confirmation that vm's have been added
## will migrate vm's immediately when rule is applied - do in small batches to avoid overloading vmware