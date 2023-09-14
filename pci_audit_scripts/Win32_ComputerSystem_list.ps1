
### You need to CD to c:\pstools before running this script ###


### Sets the error action preference. "Continue" will display the error but continue running through list. "SilentlyContinue" to supress errors ###
$ErrorActionPreference = "Continue"


### Change csv/txt document with list of servers you need to run on ###

    $servers = get-content "C:\SCRIPTS\CSV_s\next_csv\new 9.txt"

    
    foreach ($server in $servers) {

    ### Will show progress of script in green as it runs ###
    
        Write-host "Running psexec on $server" -ForegroundColor Green

        
    ### This script needs to be in the local machines c:\installs to run ###
        
        Get-WmiObject -ComputerName $server -Class Win32_ComputerSystem |Select-Object Name,Manufacturer,Model | Out-File c:\Installs\PCI_Audit_files\Win32_ComputerSystem_list.txt -Append


}


<#
C:\PSTOOLS\PSexec.exe \\end-epws118 -h -d powershell.exe -command "& { Get-WmiObject -Class Win32_ComputerSystem |Select-Object Name,Manufacturer,Model }"

Get-WmiObject -ComputerName end-epws118 -Class Win32_ComputerSystem |Select-Object Name,Manufacturer,Model

#>