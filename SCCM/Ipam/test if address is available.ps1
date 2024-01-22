<#
Test-Connection -computername END-EUAS78

172.28.193.43

Test-Connection 172.28.193.43

#>

$computer = "172.28.193.43"


if (Test-Connection $computer -Quiet -Count 1) {
    
    Write-Host "IP address $computer is in use" -ForegroundColor Red -BackgroundColor Black

} 


else {


    Write-Host "IP address $computer is free" -ForegroundColor Green -BackgroundColor Black


}