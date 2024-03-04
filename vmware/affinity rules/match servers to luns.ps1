
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

foreach ($vm in $list) {


    $datastore = Get-VM -Name $vm | Select-Object Name,@{N="Datastore";E={[string]::Join(',',(Get-Datastore -Id $_.DatastoreIdList | Select -ExpandProperty Name))}}

    $name = $datastore.Name
    $lun = $datastore.Datastore

    $0 = "0"
    $1 = "1"

    $even_servers = if ( $name.endswith($0) ) { echo "$vm is even" }
    $odd_servers = if ( $name.endswith($1) ) { echo "$vm is odd" }


        foreach ( $host in $datastore) { 


        
            if ( $name.endswith("0") ) {  }
        
        
        
        
        
        
        
        
        
         }


}