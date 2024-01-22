
$iprange = 21..254
    #This variable represents the 4th octet of the IP address. Change this to anyting between 0-254 depending on how much of the range you want to search

$search = Foreach ($ip in $iprange){

    $range = '101.10.157.'
        #This is the first 3 octets of the ip address. Will combine with the first variable to conduct the search. Change this line to search different subnets
    $computer = $range + $ip



    if (Test-Connection $computer -Quiet -Count 1) {
    
        Write-Host "IP address $computer is in use" -ForegroundColor Red -BackgroundColor Black

        

} 


        else {


            #Write-Host "IP address $computer is free" -ForegroundColor Green -BackgroundColor Black

                Write-Output "IP address $computer is free" | Out-file C:\SCRIPTS\CSV_s\next_csv\free_ips.txt -Append
                    #This line works to export to file

            #$free = Write-Output "IP address $computer is free"

}}


