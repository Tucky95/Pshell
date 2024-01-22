$Servers = Get-content "C:\Scripts\livePCs.txt"
$Folder= "c:\Software\AcroRdrDC2100520060_en_US.exe" , "c:\Software\7z1900-x64.msi"

Foreach ($Server in $Servers) {
$Test = Test-Path -path "\\$Server\c$\Temp\"

If ($Test -eq $True) {Write-Host "Path exists, hence installing softwares on $Server."}

Else {(Write-Host "Path doesnt exists, hence Creating foldet on $Server and starting installation") , (New-Item -ItemType Directory -Name Temp -Path "\\$Server\c$")}
Echo "Copying Files to C:\Temp\"
Copy-Item $Folder "\\$Server\c$\Temp\"
echo "Second Part :- Installing Software on $Server"
Invoke-Command -ComputerName $Server -ScriptBlock {(&cmd.exe /c "c:\Temp\AcroRdrDC2100520060_en_US.exe" /sAll /sr) ,
(&cmd.exe /c MSIEXEC /I "c:\Temp\7z1900-x64.msi" /qn) , (Remove-Item -path "C:\Temp\AcroRdrDC2100520060_en_US.exe" , "C:\Temp\7z1900-x64.msi" -ErrorAction Ignore)

}

}