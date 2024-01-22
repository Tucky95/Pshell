$hostname = Read-Host "Enter iLO Name"
# Define functions
function Write-ToLog
{
    param
    (
        [Parameter(
            Mandatory = $true,
            Position  = 0)]
        [string]$Message,
        [Parameter()]
        [string]$LogFilePath = "C:\Scripts\ILOencryptioncheck\"+$hostname+"_output.txt"
    )

    $Date = Get-Date -Format "HH:mm:ss"
    Tee-Object -InputObject "[$Date] $Message" -FilePath $LogFilePath -Append
}
#skips SSL checks and runs
$skip=[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
$skip
# Enter Creds and Host name

$ilo = Connect-HPEiLO -hostname $hostname -Username techserv -Password complex1ty
$secstat = ($iLo | Get-HPEiLOEncryptionSetting).SecurityState
write-tolog "$hostname is $secstat"
if (($ilo | Get-HPEiLOEncryptionSetting).SecurityState -Eq "HighSecurity") {
    Write-ToLog "[$hostname] is already high security, exiting..."
    exit
} else {
    Write-ToLog "[$hostname] Setting high security on iLO"
    $ilo | Set-HPEiLOEncryptionSetting -SecurityState HighSecurity
}
##########################################################################################
#Further checks wipe everything
##########################################################################################
$ilo = $null
write-tolog "waiting for iLo to reboot..."
start-sleep -Seconds 120
write-tolog "reconnecting..."
$ilo = Connect-HPEiLO -hostname $hostname -Username techserv -Password Complex1ty
if (($ilo | Get-HPEiLOEncryptionSetting).SecurityState -Eq "HighSecurity") {
    Write-ToLog "[$hostname] Set successfully."
    exit
} else {
    Write-ToLog "[$hostname] there has been an issue setting the security method."
    exit
}

#$exec = ($ilo | Get-HPEiLOEncryptionSetting).SecurityState
write-tolog "[$hostname] setting HighSecurity"
