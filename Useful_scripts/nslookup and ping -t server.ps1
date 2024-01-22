
$ErrorActionPreference = "SilentlyContinue"
$name = Read-Host 'Enter server name here...'


    $lookup = nslookup.exe $name 

        if ( $lookup -eq $null ) { Write-Output " $Name does not exist" }

            else { PING.EXE -t $name }