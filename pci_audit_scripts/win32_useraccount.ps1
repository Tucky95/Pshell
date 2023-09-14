﻿
### You need to CD to c:\pstools before running this script ###


### Sets the error action preference. "Continue" will display the error but continue running through list. "SilentlyContinue" to supress errors ###
$ErrorActionPreference = "Continue"


### Change csv/txt document with list of servers you need to run on ###

    $servers = get-content "C:\SCRIPTS\CSV_s\next_csv\payment server names.txt"

    
    foreach ($server in $servers) {

    ### Will show progress of script in green as it runs ###
    
        Write-host "Running psexec on $server" -ForegroundColor Green

        
    ### This script needs to be in the local machines c:\installs to run ###
        
        
        Get-WmiObject -ComputerName $server -Class Win32_UserAccount |Select-Object PSComputerName,Name,FullName,Domain,Disabled,Lockout,PasswordRequired,PasswordChangeable,PasswordExpires |Sort-Object Name |Ft|Out-String -Width 256 | out-file C:\Installs\PCI_Audit_files\win32_useraccount.txt -Append

}