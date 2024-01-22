# Set static IP's

$ips = Get-Content C:\Scripts\InternationalBuildServers\IPs.txt

# Functions

function Write-ToLog
{
    param
    (
        [Parameter(
            Mandatory = $true,
            Position  = 0)]
        [string]$Message,
        [Parameter()]
        [string]$LogFilePath = "C:\Scripts\internationalbuildservers\Output-IP.txt"
    )

    $Date = Get-Date -Format "HH:mm:ss"
    Tee-Object -InputObject "[$Date] $Message" -FilePath $LogFilePath -Append
}

$credential = Get-Credential
$username = $credential.UserName
$password = $credential.GetNetworkCredential().Password
Function ChangeIP
{
    foreach ($ip in $ips)
        {
            Write-ToLog "Setting IP address onn $ip"
           C:\PSTOOLS\PSexec.exe -u $username -p $password -h \\ip powershell.exe "C:\installs\ip.bat" 
           Write-ToLog "IP has been set"
        }
}

function disableadmin
{
    foreach ($ip in $ips){
    Write-ToLog "[$ip] Disabling Admin..."
    c:\pstools\psexec.exe -u $username -p $password -h \\$ip cmd.exe /c "net user jagrant_deploy /active:no"
    }}

Disableadmin