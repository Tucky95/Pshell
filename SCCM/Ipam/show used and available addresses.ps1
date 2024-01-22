
$iprange = 1..15

Foreach ($ip in $iprange){
    
    $computer = "172.28.193.$ip"
    $status = Test-Connection $computer -count 1 -Quiet
    
    if (!$status)
{
$computer + ” – available”
}
else
{
$computer + ” – not available”
}}