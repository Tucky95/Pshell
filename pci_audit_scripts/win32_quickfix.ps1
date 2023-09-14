
 
### You need to CD to c:\pstools before running this script ###


### Sets the error action preference. "Continue" will display the error but continue running through list. "SilentlyContinue" to supress errors ###
$ErrorActionPreference = "Continue"


### Change csv/txt document with list of servers you need to run on ###

    $servers = get-content "C:\SCRIPTS\CSV_s\next_csv\new 9.txt"

    
    foreach ($server in $servers) {

    ### Will show progress of script in green as it runs ###
    
        Write-host "Running Get-WmiObject -Class Win32_QuickFixEngineering on $server" -ForegroundColor Green

        
    ### This script needs to be in the local machines c:\installs to run ###
        
        C:\PSTOOLS\PSexec.exe \\$server -h -d powershell.exe -command "& { Get-WmiObject -Class Win32_QuickFixEngineering |Select-Object pscomputername,HotFixID,Description,InstalledOn |Sort-Object InstalledOn -Descending | export-csv C:\Installs\PCI_Audit_files\quickfix_output.csv -NoTypeInformation }"

         #Get-WmiObject -Class Win32_QuickFixEngineering |Select-Object pscomputername,HotFixID,Description,InstalledOn |Sort-Object Installed-On -Descending




}


<#
C:\PSTOOLS\PSexec.exe \\end-epws120 powershell.exe -command "& { Get-WmiObject -Class Win32_QuickFixEngineering |Select-Object pscomputername,HotFixID,Description,InstalledOn |Sort-Object Installed-On -Descending }"

Get-WmiObject -Class Win32_QuickFixEngineering |Select-Object pscomputername,HotFixID,Description,InstalledOn |Sort-Object Installed-On -Descending | export-csv C:\Installs\PCI_Audit_files\quickfix_output.csv -NoTypeInformation

C:\PSTOOLS\PSexec.exe \\end-epws120 powershell.exe -command "& { Get-WmiObject -Class Win32_QuickFixEngineering |Select-Object pscomputername,HotFixID,Description,InstalledOn |Sort-Object InstalledOn -Descending | export-csv C:\Installs\PCI_Audit_files\quickfix_output.csv -NoTypeInformation }"

Get-WmiObject -Class Win32_QuickFixEngineering |Sort-Object Installed-On -Descending |Select-Object pscomputername,HotFixID,Description,InstalledOn

C:\PSTOOLS\PSexec.exe \\end-epws120 powershell.exe -command "& { Get-WmiObject -Class Win32_QuickFixEngineering |Sort-Object Installed-On -Descending |Select-Object InstalledOn,pscomputername,HotFixID,Description | export-csv C:\Installs\PCI_Audit_files\quickfix_output3.csv -NoTypeInformation }"

C:\PSTOOLS\PSexec.exe \\end-epws120 powershell.exe -command "& { Get-WmiObject -Class Win32_QuickFixEngineering |Sort-Object Installed-On -Descending |Select-Object InstalledOn,pscomputername,HotFixID,Description }"

#>