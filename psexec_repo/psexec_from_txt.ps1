
### You need to CD to c:\pstools before running this script ###


### Sets the error action preference. "Continue" will display the error but continue running through list. "SilentlyContinue" to supress errors ###
$ErrorActionPreference = "Continue"


### Change csv/txt document with list of servers you need to run on ###

    $servers = get-content "C:\temp\dns_need_changing.txt"

    
    foreach ($server in $servers) {

    ### Will show progress of script in green as it runs ###
    
        Write-host "Running psexec on $server" -ForegroundColor Green

        
    ### This script needs to be in the local machines c:\installs to run ###
        
        C:\PSTOOLS\PSexec.exe \\$server -h -d powershell.exe -command "& {Get-DnsClientServerAddress | Select-Object -ExpandProperty ServerAddresses}" -nobanner




}

