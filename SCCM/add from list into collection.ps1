$collectionname = “RDS Deploy Collection”
$Computers = Get-content “c:\temp\Server_List.txt”
$logpath = “c:\temp”


foreach($computer in $computers) {

try {

Write-Host “Adding $computer to $collectionname” -ForegroundColor Green
Add-CMDeviceCollectionDirectMembershipRule -CollectionName $collectionname -ResourceId (get-cmdevice -Name $computer).ResourceID

}

catch {

Write-Warning “Cannot add client $computer object may not exist”
$computer | Out-File “$logpath\$collectionname-invalid.log” -Append
$Error[0].Exception | Out-File “$logpath\$collectionname-invalid.log” -Append


}
}