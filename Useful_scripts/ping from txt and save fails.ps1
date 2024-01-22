$computers = Get-Content "C:\Installs\sql_server_dns.txt"

foreach ($computer in $computers) {
    
$pingComputer = Test-Connection $computer -Count 1 -Quiet
    
if ($pingComputer) {
        
    Write-Host "$computer is up" -ForegroundColor Green
    

} 


else {
        
    
    Write-Host "$computer is down" -ForegroundColor Red -BackgroundColor White

        $failures = Write-Output "$computer is down"


     
    


    }
}


$failures | Out-File C:\Installs\sql_failed_ping.txt