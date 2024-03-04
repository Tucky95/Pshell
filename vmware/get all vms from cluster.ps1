
# Connect to vmware variables
$Server = "end-epvc01.next-uk.next.loc"
$creds = Get-StoredCredential -Target 'next'
#Set-PowerCLIConfiguration -InvalidCertificateAction "ignore"



         ################## Unhash the below to connect to vmware ############

        #Connect-VIServer -Server $Server -Protocol https -Credential $creds
            
        ##################### Will prompt for DUO ###########################


    
    # Cluster variables
    $cluster = "end-epvh18-cluster"

        Get-VM -Location $cluster | select Name | Export-Csv "C:\CSV\all_epvh18_vms.csv" -NoTypeInformation