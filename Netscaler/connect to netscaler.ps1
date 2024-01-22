# Path to Netscaler pshell cmdlets NetScaler\NetScaler.psd1

# Install-Module -Name NetScaler -RequiredVersion 1.5.0
    #Command to install Netscaler module

$Nsip = "172.28.18.135"
$credential = Get-StoredCredential -Target 'next'

$Session =  Connect-Netscaler -Hostname $Nsip -Credential $Credential -PassThru

#Set-NSHostname -Hostname "ecom_dev_ns" -Force -Session $Session

Get-NSLBServer -Name "svr_euas78"
    # Get Server details

Get-NSLBVirtualServer -Name "vsrv_ldrelayproxy_uat"
    # Get Load Balanced Virtual Server Details


.\Get-NSLBService.ps1 -Name 'svc_euas78_ldrelayproxy_8030'
    #created myself = doesn't work


Invoke-Nitro -Session $Session -Method Get -Type Service 'svc_euas78_ldrelayproxy_8030' -Action Get | ConvertTo-Json
    #all commands run this invoke-nitro as a commandlet. This is a manual way of get service details

Disconnect-NetScaler
    # Disconnect Netscaler Powershell session