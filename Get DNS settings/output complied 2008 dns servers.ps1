$Servers = import-csv "C:\temp\new12.csv"

$Servers | ForEach-Object { 

    $name = $_.Name
    $file = $name + "_dmz_dns_servers.txt"
    $path = "\\" + $name + "\c$\installs\" + $file

    $get = Get-Content $path 
    
    $name + "|" + $get |  Out-File C:\temp\dns_output4.txt -Append


}
