# Run this in an admin PS window
## Run the import line first 
Import-Module WebAdministration

$get_all_iis = Get-Content "C:\installs\check iis recycle times\app_pool_list.txt"

    foreach ($pool in $get_all_iis) {

        $name = $pool


            Write-Host "$name recycle time is set to..." -ForegroundColor Green

            Get-ItemProperty -Path IIS:\AppPools\$name -Name recycling.periodicRestart.schedule.collection | FT Value


    }