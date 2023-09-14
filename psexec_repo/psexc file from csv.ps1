
$csv = Import-Csv "C:\CSV\dc12_test_list.csv"

        $CSV | ForEach-Object { 

            $name = "\\"  + $_.Name
           

      Write-host $name
     
     C:\PSTOOLS\PsExec.exe $name -h -d powershell.exe -File "C:\Installs\dns_script\dns_demotion\list_address_and_index.ps1" -nobanner



}
