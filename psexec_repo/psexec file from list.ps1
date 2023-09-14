
### You need to CD to c:\pstools before running this script ###


### Sets the error action preference. "Continue" will display the error but continue running through list. "SilentlyContinue" to supress errors ###
    
    $ErrorActionPreference = "Continue"

### Change csv/txt document with list of servers you need to run on ###

    $servers = Get-content "C:\CSV\jtuck_test_names.txt"



    foreach ($server in $servers)
{

    ### Will show progress of script in green as it runs ###

        Write-host "Running psexec on $server" -ForegroundColor Green


    ### Will run the file saved on locally on the machine after the -File paramater ###

        C:\PSTOOLS\PSexec.exe \\$server -h -d powershell.exe -File "C:\Installs\dns_demotion\list_address_and_index.ps1" -nobanner

}

