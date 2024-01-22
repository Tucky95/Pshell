
$Name = Read-Host 'Enter Server Name Here'
$Mac_Address = Read-Host 'Enter MAC Address Here'
$Guid = Read-Host 'Enter SMBiosGuid Here'


## Search for dupe MAC Address in SCCM ##

    Write-Host 'Searching SCCM for duplicate entries of the entered MAC Address...' -ForegroundColor DarkCyan

$Search_mac = Get-CMDevice -Fast | Where-Object { $_.MACAddress -eq $Mac_Address } | Select -ExpandProperty Name


    if ( $Search_mac ) {write-host "This MAC Address is already assigned to $Search_mac" -ForegroundColor Red }

        else { Write-Host "This MAC Address is not currently in SCCM" -ForegroundColor Green }

    
## Search for dupe GUID in SCCM ##
    
    Write-Host 'Searching SCCM for duplicate entries of the entered MAC Address...' -ForegroundColor DarkCyan

$Search_GUID = Get-CMDevice -Fast | Where-Object { $_.SMBIOSGUID -eq $Guid } | Select -ExpandProperty Name

    if ( $Search_GUID ) {write-host "This GUID is already assigned to $Search_GUID" -ForegroundColor Red }

        else { Write-Host "This MAC Address is not currently in SCCM" -ForegroundColor Green }