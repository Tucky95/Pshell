
$iprange = 1..15

Foreach ($ip in $iprange){
    
    $computer = "172.28.193.$ip"
    $status = Test-Connection $computer -count 1 -Quiet
    
    if (!$status)
    

    {
       
        
       Write-Output "$computer - available" 
    
    
    }
}



#1..15 | foreach { $status=Test-Connection "172.28.193.$_" -Count 1 -Quiet; "172.28.193.$_ $status"}