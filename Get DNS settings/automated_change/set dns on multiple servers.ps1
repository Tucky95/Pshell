
# csv file that the compiled list of DNS files will be created from
    $CSV = import-csv "C:\CSV\clean_jtuck_dns_compiled.csv"


<#  Set DNS in this order:    

    172.28.64.25
    172.28.65.37
    172.28.65.39
    172.28.64.26

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

