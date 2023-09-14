
# csv file that the compiled list of DNS files will be created from
    $CSV = import-csv "C:\CSV\1st DNS change.csv"
    $output_location = "C:\CSV\post_dns_change1_compiled.csv"


<#  Set DNS in this order:    

    172.28.64.25 END-DMZ-IPDC14
    172.28.65.37 END-DMZ-IPDC13
    172.28.65.39 END-DMZ-IPDC12
    172.28.64.26 END-DMZ-IPDC11

#>

$CSV | ForEach-Object { 

    
    $name = "\\" + $_.Name
    $index = $_.'InterfaceIndex'
    

    Write-Host "Setting DNS priority on $name using interface $index" -ForegroundColor Green
    
        C:\PSTOOLS\PSexec.exe $name powershell.exe -command "& { 
        

                
        Set-DnsClientServerAddress -ServerAddresses ('172.28.64.25','172.28.65.37','172.28.65.39','172.28.64.26') -InterfaceIndex $index 
        
        
        ipconfig.exe /flushdns


                       
        
        }" -nobanner


}


        $CSV | ForEach-Object { 

            $name = "\\"  + $_.Name
           

      Write-host "Running list_address_and_index script locally on $name" -ForegroundColor Green
     
     C:\PSTOOLS\PsExec.exe $name -h -d powershell.exe -File "C:\Installs\dns_script\dns_demotion\list_address_and_index.ps1" -nobanner



}



        $CSV | ForEach-Object { 

            $name = $_.Name
            $file = "dns_index_output.csv"
            $path = "\\" + $name + "\c$\installs\dns_script\dns_demotion\" + $file

            $get = Get-Content $path 
    
            Write-Host "Compiling DNS settings for server $name" -ForegroundColor Green
            $get |  Out-File $output_location -Append
    

}



# Opens compiled list at the end of the script. Change this location to match $output_location
          Invoke-item $output_location