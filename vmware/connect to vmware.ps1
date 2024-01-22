
## NEED TO INSTALL MODULE!! ##

$Username = Read-Host "Username:"
$Password = Read-Host "Password:" -AsSecureString
$vCenter = Read-Host "vCenter Server:"
$DataCenter = Read-Host "Datacenter:"

#Connect to vCenter
$SecureCredential = New-Object System.Management.Automation.PSCredential -ArgumentList $Username, $Password
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false
Connect-VIServer -Server $vCenter -User $SecureCredential.UserName -Password ([Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureCredential.Password)))
