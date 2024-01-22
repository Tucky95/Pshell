

$question = $( Write-Host "Have you eaten lunch yet? " -ForegroundColor Red -BackgroundColor White -NoNewline; Read-Host )

    if ( $question -eq "Yes" ) { Write-Host "Good boy" -ForegroundColor Green }

        elseif ( $question -eq "No" ) { Return  }


        PING.EXE 8.8.8.8




        Read-Host 
        
        "ONLY RUN THIS SCRIPT IF:
        
        - BOTH NIC'S ARE ENABLED
        - THE VCEM PROFILE IS ON THE 101
        - CHECKPOINT FW RULES ARE IN PLACE
        
        Have these conditions been met? "


#change read-host font colour
$input = $(Write-Host "Please, type your Name" -NoNewLine) + $(Write-Host " EX: Praveen Kumar " -ForegroundColor yellow -NoNewLine; Read-Host) 


        write-Host "
        
        ONLY RUN THIS SCRIPT IF:
        
        - BOTH NIC'S ARE ENABLED
        - THE VCEM PROFILE IS ON THE 101
        - CHECKPOINT FW RULES ARE IN PLACE
        
        Have these conditions been met? 

        " -ForegroundColor Yellow


$colour_question = $( Write-Host "

ONLY RUN THIS SCRIPT IF: 

- BOTH NIC'S ARE ENABLED 
- THE VCEM PROFILE IS ON THE 101 
- CHECKPOINT FW RULES ARE IN PLACE

Have these conditions been met? Script will terminate if you answer No. Enter Yes to continue... 

" -ForegroundColor Yellow -NoNewline; Read-Host)