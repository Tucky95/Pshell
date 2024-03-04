
# Connect to vmware variables
$Server = "end-epvc01.next-uk.next.loc"
$creds = Get-StoredCredential -Target 'next'
#Set-PowerCLIConfiguration -InvalidCertificateAction "ignore"

Connect-VIServer -Server $Server -Protocol https -Credential $creds
    # Will prompt for DUO
