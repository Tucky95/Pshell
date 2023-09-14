
$Servers = import-csv "C:\CSV\test_list.csv"

$Servers | ForEach-Object { 

    $name = $_.Name
    $file = $name + "_dmz_dns_servers.txt"
    $path = "\\" + $name + "\c$\installs\" + $file

    $get = Get-Content $path 
    
    Write-Host "Compiling DNS settings for server $name" -ForegroundColor Green
    $name + "|" + $get |  Out-File C:\CSV\test_dns_output.txt -Append
    

}
        