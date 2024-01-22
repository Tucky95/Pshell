
Import-Module SwisPowerShell

# Swis connection info
$OrionServer = "END-EPMC58-CL02"
$Username = "next-plc\jtuck"
$Password = ""

$creds = Get-StoredCredential -Target 'solarwinds'


    
$swis = Connect-Swis -Hostname "https://172.28.17.195" -Trusted

Get-SwisData $swis 'SELECT NodeID, Caption FROM Orion.Nodes'

    


Connect-Swis -Credential $creds -Hostname "solarwinds/Orion/Login.aspx?ReturnUrl=%2fOrion%2fSummaryView.aspx%3fViewID%3d1&ViewID=1"

Connect-Swis -Hostname "https://172.28.17.195/swvm/services/InformationService" -Trusted

/swvm/services/InformationService