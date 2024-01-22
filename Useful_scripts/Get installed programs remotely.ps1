
$name = "END-EUWS51"



Get-WmiObject -Class Win32_Product -ComputerName $name |
Select-Object -Property PSComputerName, Name, Version |
Where-Object {$_.Name -like "Veritas*"}