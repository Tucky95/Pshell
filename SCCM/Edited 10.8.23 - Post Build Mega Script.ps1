#Updated 27th July to fix issue with adding JITA accounts - MNICE/JTUCK
#Updated 25th July Add SVC-PSTEPROD-GRP, SVC-Orchestrator-DB and USRS-Deployments to JITA - MNICE/JTUCK
#Updated 25th July Add SVC-PSTEPROD-GRP, SVC-Orchestrator-DB and USRS-Deployments to local admins group - MNICE/JTUCK
#Updated 26th May 2023 Remove rogue certificates - MNICE
#Updated 7th April 2023 check admin password - MNICE
#Updated 21st March 2023 to only install Rubrik if Physical - MNICE
#updated 14th March 2023 to address issues when running on 2019 - MNICE
#updated 7th Feb 2023 to prompt for local admin name - MNICE
#updated 26th Jan 2023 fix Rubrik and remove compress command which has never worked - MNICE
#Updated 22nd Jan disable Dynatrace - MNICE
#Updated 20th Jan 2023 with Rubrik and supression of static route removal errors - MNICE

$ErrorActionPreference = "Continue"

$Environment = switch ($env:COMPUTERNAME.Substring(4,2))
{
    "ED"
    {
        "Dev"
    }
    "EU"
    {
        "UAT"
    }
    "ES"
    {
        "Staging"
    }
    "EP"
    {
        "Prod"
    }
}

#Get OS Version - MNICE
$OSVersion = (get-itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ProductName).ProductName

#Ask engineer to confirm pre-requisites

    $user_prompt = $( Write-Host "

            ONLY RUN THIS SCRIPT IF: 

                - BOTH NIC'S ARE ENABLED 
                - THE VCEM PROFILE IS ON THE 101 
                - CHECKPOINT FW RULES ARE IN PLACE

     Have these conditions been met? Script will terminate if you answer No. Enter Yes to continue... 

" -ForegroundColor Yellow -NoNewline; Read-Host)

    if ($user_prompt -eq "Yes" ) { Write-Host "Starting Post Build Script..." -ForegroundColor Green }

        elseif ( $user_prompt -eq "No" ) { Return  }


# Import powershell script to run custom commands
    Import-Module C:\installs\PostBuildScript\eCommercePS\Jita\jita_ps_module_url_populated.ps1



    #Set local server name as variable
        $server_name = $env:computername

        $network_location = Read-Host 'Is the server hosted on DMZ or Corp'

            if ( $network_location -eq 'DMZ' ) { 
            
                $DMZ_name = $server_name + '.dmz.next-uk.next.loc' 
                
                
                #Persistent accounts
            Write-Host "Setting persistent accounts..." -ForegroundColor Green
            
                persist "NEXT-PLC\USRS-SVC-SupportLevel1" -computer_name $DMZ_name -force
            
                persist "NEXT-PLC\USRS-ICE SVC Accounts" -computer_name $DMZ_name -force

                persist "NEXT-PLC\SVC-PSTEPROD-GRP" -computer_name $DMZ_name -force

                persist "NEXT-PLC\SVC-Orchestrator-DB" -computer_name $DMZ_name -force
            
            
            
          #Unpersistent accounts
            Write-Host "Setting unpersistent accounts..." -ForegroundColor Cyan
            
                unpersist "NEXT-PLC\USRS-ICE Support" -computer_name $DMZ_name -force

                unpersist "NEXT-PLC\USRS-SupportLevel1" -computer_name $DMZ_name -force

                unpersist "NEXT-PLC\USRS-Deployments" -computer_name $DMZ_name -force
                
                
                
                              
                
}

            elseif ( $network_location -eq 'Corp' ) { 
            
                    $Corp_name = $server_name + '.next-uk.next.loc' 
                    
                    
                      #Persistent accounts
            Write-Host "Setting persistent accounts..." -ForegroundColor Green
            
                persist "NEXT-PLC\USRS-SVC-SupportLevel1" -computer_name $Corp_name -force
            
                persist "NEXT-PLC\USRS-ICE SVC Accounts" -computer_name $Corp_name -force

                persist "NEXT-PLC\SVC-PSTEPROD-GRP" -computer_name $Corp_name -force

                persist "NEXT-PLC\SVC-Orchestrator-DB" -computer_name $Corp_name -force
            
            
            
          #Unpersistent accounts
            Write-Host "Setting unpersistent accounts..." -ForegroundColor Cyan
            
                unpersist "NEXT-PLC\USRS-ICE Support" -computer_name $Corp_name -force

                unpersist "NEXT-PLC\USRS-SupportLevel1" -computer_name $Corp_name -force

                unpersist "NEXT-PLC\USRS-Deployments" -computer_name $Corp_name -force
                    
                    
                    
    }

#Import-Module ActiveDirectory - commented out as fails and not needed

#### #### #### #### #### #### #### #### ####
####  Function definitions and prereqs  ####
#### #### #### #### #### #### #### #### ####

[int]$Global:ErrCount = 0

class InstallationInstructions
{
    [string]$FullName
    [string]$FilePath
    [array]$ArgumentList
    [switch]$IgnoreValidation
    [string]$AdditionalScript
    [string]GetFileType()
    {
        return [regex]::Match($this.FilePath,'[^\.]([A-z0-9]+)$')
    }
}

function Get-ComputerPlatform
{
    $WMIModel = (Get-WmiObject Win32_ComputerSystem).Model

    if($WMIModel -eq "Virtual Machine"){
        $Platform   = "Virtual"
        $Hypervisor = "Hyper-V"
    }
    elseif($WMIModel -like "VMWare*"){
        $Platform   = "Virtual"
        $Hypervisor = "VMWare"
    }
    else{
        $Platform = "Physical"
        $Hypervisor = "Bare Metal"
    }
    return New-Object PSObject -Property @{
        Platform   = $Platform
        Hypervisor = $Hypervisor
    }
}

function Write-ToLog
{
    param
    (
        [Parameter(
            Mandatory = $true,
            Position  = 0)]
        [string]$Message,
        [Parameter()]
        [string]$LogFilePath = "C:\Installs\PostBuildLog.txt",
        [switch]$Attention
    )

    if ($Attention -eq $true)
    {
        $Global:ErrCount++
    }
    $Date = Get-Date -Format "HH:mm:ss"
    Tee-Object -InputObject "[$Date] $Message" -FilePath $LogFilePath -Append
}

function Confirm-Installation
{
    param
    (
        [Parameter(Mandatory = $true)]
        [InstallationInstructions]$Program
    )

    # Validate the installation
    if ($Program.FullName -in (Get-Package).Name)
    {
        Write-ToLog "$($Program.FullName) successfully installed"
        if ($Program.AdditionalScript)
        {
            Write-ToLog "Executing additional script for $($Program.FullName)"
            try
            {
                Invoke-Expression $Program.AdditionalScript
                Write-ToLog "Additional script executed successfully"
            }
            catch
            {
                throw "Additional script failed: $($_.Exception.Message)"
            }
        }
    }
    elseif ($Program.IgnoreValidation -eq $true)
    {
        Write-ToLog "$($Program.FullName) configuration successfully applied"
    }
    else
    {
        throw "$($Program.FullName) validation failed"
    }
}

function Install-Program
{
    param
    (
        [Parameter(Mandatory = $true)]
        [InstallationInstructions]$Program,
        [switch]$Reinstall
    )

    $InstalledPrograms = Get-Package

    # Unfortunate special case for FireEye
    if ($Program.FullName -eq "FireEye Endpoint Agent")
    {
        try
        {
            switch ($Program.ArgumentList[1])
            {
                "/x"
                {
                    $Action = "Uninstall"
                    if ($Program.FullName -notin $InstalledPrograms.Name)
                    {
                        throw "FireEye not installed"
                    }
                }
                "/i"
                {
                    $Action = "Install"
                    if ($Program.FullName -in $InstalledPrograms.Name)
                    {
                        throw "FireEye is already installed"
                    }
                }
            }
            Write-ToLog "$($Action)ing $($Program.FullName)"
            Start-Process msiexec.exe -ArgumentList $Program.ArgumentList -Wait
            if ($Action -eq "Install")
            {
                Confirm-Installation $Program
                return
            }
            Write-ToLog "$($Program.FullName) successfully $($Action)ed"
        }
        catch
        {
            Write-ToLog "$($Action)ing FireEye failed: $($_.Exception.Message)" -Attention
            return
        }
    }
    else
    {
        if ($Reinstall -eq $true -and $Program.FullName -in $InstalledPrograms.Name)
        {
            try
            {
                Write-ToLog "Uninstalling $($Program.FullName)"
                Uninstall-Package -Name $Program.FullName | Out-Null
                if ($Program.FullName -notin (Get-Package).Name)
                {
                    Write-ToLog "Uninstallation successful"
                }
                else
                {
                    throw "Unknown Error"    
                }
            }
            catch
            {
                Write-ToLog -Message "Failed to uninstall $($Program.FullName): $($_.Exception.Message)" -Attention
                return
            }
        }

        if ($Program.FullName -notin (Get-Package).Name)
        {
            try
            {
                # Install program
                Write-ToLog "Installing $($Program.FullName)"
                switch ($Program.GetFileType())
                {
                    "msi"
                    {
                        Start-Process msiexec.exe -ArgumentList $Program.ArgumentList -Wait
                    }
                    "exe"
                    {
                        Start-Process $Program.FilePath -ArgumentList $Program.ArgumentList -Wait
                    }
                    default
                    {
                        throw "Missing or unsupported file type"
                    }
                }

                Confirm-Installation $Program
            }
            catch
            {
                Write-ToLog -Message "Installation unsuccessful: $($_.Exception.Message)" -Attention
                return
            }
        }
        else
        {
            Write-ToLog "$($Program.FullName) already installed"
        }
    }
}

function Install-SMBSigningFix
{
    try
    {
        Set-ItemProperty    "Registry::HKLM\System\CurrentControlSet\Services\LanManWorkstation\Parameters"`
                            -PSProperty "RequireSecuritySignature" -Value 1

        Set-ItemProperty    "Registry::HKLM\System\CurrentControlSet\Services\LanManWorkstation\Parameters"`
                            -PSProperty "EnableSecuritySignature" -Value 1                        

        Set-ItemProperty    "Registry::HKLM\System\CurrentControlSet\Services\LanManServer\Parameters"`
                            -PSProperty "RequireSecuritySignature" -Value 1

        Set-ItemProperty    "Registry::HKLM\System\CurrentControlSet\Services\LanManServer\Parameters"`
                            -PSProperty "EnableSecuritySignature" -Value 1

        Write-ToLog "Successfully applied SMB Signing Fix"
    }
    catch
    {
        Write-ToLog "Failed to apply SMB Signing Fix: $($_.Exception.Message)" -Attention
    }
}

function Update-ServerID
{
    $ServerID = [Regex]::Match($env:COMPUTERNAME,'[0-9].*').Value
    $Find     = "ServerID=1024"
    $Replace  = "ServerID=$ServerID"
    $Source   = "C:\Installs\New Server Scripts\Source\AdminTransactionalBLACK.cfg"
    $Dest     = "D:\Inetpub\COM Objects\AdminTransactionalBLACK.cfg"

    try
    {
        (Get-Content $Source).Replace($Find,$Replace) | Set-Content $Dest -Force
        Write-ToLog "ServerID updated to $ServerID"
    }
    catch
    {
        Write-ToLog "Failed to update server ID: $($_.Exception.Message)" -Attention
    }
}

function Install-COMPlusApplication
{
    param
    (
        [Parameter(Mandatory = $true)]
        [Array]$Applications
    )

    begin
    {
        try
        {
            Write-ToLog "Fetching COM+ applications, this could take a while"
            $Catalog       = New-Object -ComObject COMAdmin.COMAdminCatalog
            $InstalledApps = $Catalog.GetCollection("Applications")
            $InstalledApps.Populate()
        }
        catch
        {
            Write-ToLog "Failed to fetch COM+ applications: $($_.Exception.Message)" -Attention
            return
        }
    }

    process
    {
        foreach ($Application in $Applications)
        {
            if ($Application.FullName -notin ($InstalledApps | Select-Object Name).Name)
            {
                try
                {
                    Write-ToLog "Installing $($Application.FullName)"
                    $Catalog.InstallApplication($Application.FilePath,"D:\inetpub\COM Objects\", 1, "dmz\gintmq6", "Mqser1es")
                    Write-ToLog "Successfully Installed $($Application.FullName)"
                }
                catch
                {
                    Write-ToLog "Failed to install $($Application.FullName): $($_.Exception.Message)" -Attention
                    return
                }
            }
            else
            {
                Write-ToLog "$($Application.FullName) already installed"
            }
        }
    }

    end
    {
        try
        {
            [Environment]::SetEnvironmentVariable("SEE_MASK_NOZONECHECKS","1","Machine")
            Write-ToLog "Successfully set environment variable `"SEE_MASK_NOZONECHECKS`",`"1`",`"Machine`""
        }
        catch
        {
            Write-ToLog "Failed to set environment variable `"SEE_MASK_NOZONECHECKS`",`"1`",`"Machine`"" -Attention
        }
    }
}

function Install-DotNET35
{
    param
    (
        [switch]$Reinstall
    )

    if ("NET-framework-Core" -in (Get-WindowsFeature | Where-Object {$_.Installed -eq $true}).Name -and $Reinstall -ne $true)
    {
        Write-ToLog ".NET 3.5 already installed"
    }
    else
    {
        try
        {
            Write-ToLog "Installing .NET 3.5"
            Install-WindowsFeature "Net-Framework-Core" -Source 'C:\Installs\New Server Scripts\Source' | Out-Null
            Write-ToLog "Successfully installed .NET 3.5"
        }
        catch
        {
            Write-ToLog "Failed to install .NET 3.5: $($_.Exception.Message)" -Attention
        }            
    }
}

function Set-FoldersAndShares
{
    $Share = 'C:\Installs\New Server Scripts\Source\shares.reg'

    "Config","Inetpub","Inetpub\COM Objects","inetpub-accountportal","inetpub-blservices","inetpub-tracking","Logfiles","scripts" | ForEach-Object {

        if (!(Test-Path "D:\$_"))
        {
            New-Item -Path "D:\$_" -ItemType Directory | Out-Null
            Write-ToLog "Created directory D:\$_"
        }
    }

    "Logfiles","Logs" | ForEach-Object {

        if (!(Test-Path "E:\$_"))
        {
            New-Item -Path "E:\$_" -ItemType Directory | Out-Null
            Write-ToLog "Created directory E:\$_"
        }
    }

    try
    {
        regedit /s $Share

        Start-Sleep 5

        # Check the registry settings because a failed attempt won't error
        try
        {
            $RegistryProperties = (Get-ItemProperty "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Shares" | Get-Member).Name
        }
        catch
        {
            throw "Could not find registry key Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Shares"
        }
        $NotFound = @()
        "config$","etc$","Inetpub$","inetpub-accountportal$","inetpub-blservices$","inetpub-tracking$","logsd$","LogsE$","scripts$" | ForEach-Object {

            if ($_ -notin $RegistryProperties)
            {
                $NotFound += $_
            }
        }
        if ($NotFound.Count -gt 0)
        {
            throw "The following properties were not found: $($NotFound -join (", "))"
        }
        else
        {
            Write-ToLog "Successfully imported registry share settings"
        }
    }
    catch
    {
        Write-ToLog "Failed to import registry share settings: $($_.Exception.Message)" -Attention
        return
    }

    try
    {
        Get-Service 'Server' | Stop-Service
        Get-Service 'Server' | Start-Service    
    }
    catch
    {
        Write-ToLog "Failed to restart Server service: $($_.Exception.Message)" -Attention
    }
}

function Enable-RDP
{
    try
    {
        Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
        Enable-NetFirewallRule -DisplayGroup "Remote Desktop"    
        Write-ToLog "Successfully enabled RDP"
    }
    catch
    {
        Write-ToLog "Failed to enable RDP: $($_.Exception.Message)" -Attention
    }
}

function Enable-Remoting
{
    try
    {
        Enable-PSRemoting   -Force | Out-Null
        Enable-WSManCredSSP -Role Server -Force | Out-Null
        Enable-WSManCredSSP -Role Client -DelegateComputer *.next-uk.next.loc -Force | Out-Null
        Write-ToLog "Successfully enabled remoting"
    }
    catch
    {
        Write-ToLog "Failed to enable remoting: $($_.Exception.Message)" -Attention
    }
}

function Invoke-OneLiners
{
    param
    (
        [String]$SourceFile = "C:\Installs\New Server Scripts\Source\OneLiners.txt"
    )

    $OneLiners = Get-Content $SourceFile

    foreach ($Line in $OneLiners)
    {
        try
        {
            Write-ToLog "Executing `"$Line`""
            Invoke-Expression $Line | Out-Null
        }
        catch
        {
            Write-ToLog "Failed to execute `"$Line`": $($_.Exception.Message)"
        }
    }
}

function Install-LogClearDownTask
{
    $Source  = "C:\installs\New Server Scripts\Source\LogClear\LogClear.bat"
    $Source2 = "C:\installs\New Server Scripts\Source\LogClear\ClearLogSubFolders.vbs"
    $Dest    = "$env:windir\System32"

    try
    {
        Copy-Item -Path $Source  -Destination $Dest -Force
        Copy-Item -Path $Source2 -Destination $Dest -Force
        Write-ToLog "LogClear.bat moved successfully"
    }
    catch
    {
        Write-ToLog "Failed to move LogClear.bat" -Attention
        return
    }

    if ("Log Cleardown" -notin (Get-ScheduledTask).TaskName)
    {
        try
        {
            Register-ScheduledTask -Xml (Get-Content "C:\installs\New Server Scripts\Source\LogClear\LogCleardown.xml" | Out-String) -TaskName "Log Cleardown" | Out-Null
            Write-ToLog "Successfully registered LogClearDown task"
        }
        catch
        {
            Write-ToLog "Failed to register Log ClearDown task: $($_.Exception.Message)" -Attention
        }
    }
    else
    {
        Write-ToLog "Log Cleardown task already installed"
    }
}

function Uninstall-SilverLight
{
    if ("Microsoft Silverlight" -in (Get-Package).Name)
    {
        try
        {
            Uninstall-Package -Name "Microsoft Silverlight" | Out-Null
            Write-ToLog "Succesfully uninstalled Silverlight"
        }
        catch
        {
            Write-ToLog "Failed to uninstall Silverlight: $($_.Exception.Message)" -Attention
        }
    }
    else
    {
        Write-ToLog "Did not find Silverlight to uninstall"
    }
}

function Set-MainframeRoutes
{

    if (-not (Get-NetRoute -PolicyStore "PersistentStore" | Where-Object {$_.DestinationPrefix -eq "194.169.114.0/24"}))
    {
        try
        {
            $Index = (Get-NetAdapter | Where-Object {$_.Status -eq "Up"}).ifIndex[0]    
            New-NetRoute -DestinationPrefix "194.169.114.0/24" -InterfaceIndex $Index -NextHop 101.10.109.1 -RouteMetric 1 | Out-Null
            New-NetRoute -DestinationPrefix "194.169.114.0/24" -InterfaceIndex $Index -NextHop 101.10.109.5 -RouteMetric 1 | Out-Null
            Write-ToLog "Successfully set Mainframe routes for 194.169.114.0/24"
        }
        catch
        {
            Write-ToLog "Failed to set Mainframe routes for 194.169.114.0/24: $($_.Exception.Message)" -Attention
        }
    }
    else
    {
        Write-ToLog "Mainframe route for 194.169.114.0/24 already exists"
    }
    
    if (-not (Get-NetRoute -PolicyStore "PersistentStore" | Where-Object {$_.DestinationPrefix -eq "192.168.210.0/24"}))
    {
        try
        {
            $Index = (Get-NetAdapter | Where-Object {$_.Status -eq "Up"}).ifIndex[0]
            New-NetRoute -DestinationPrefix "192.168.210.0/24" -InterfaceIndex $Index -NextHop 101.10.109.1 -RouteMetric 1 | Out-Null
            New-NetRoute -DestinationPrefix "192.168.210.0/24" -InterfaceIndex $Index -NextHop 101.10.109.5 -RouteMetric 1 | Out-Null
            Write-ToLog "Successfully set Mainframe routes for 192.168.210.0/24"
        }
        catch
        {
            Write-ToLog "Failed to set Mainframe routes for 192.168.210.0/24: $($_.Exception.Message)" -Attention
        }
    }
    else
    {
        Write-ToLog "Mainframe route for 192.168.210.0/24 already exists"
    }
}



function Install-RolesAndFeatures
{
    $Features = Get-Content "C:\Installs\New Server Scripts\Source\Roles.txt"

    Write-ToLog "Installing Windows Features"
    $ExistingFeatures = (Get-WindowsFeature | Where-Object {$_.Installed -eq $true}).Name
    foreach ($Feature in $Features)
    {
        if ($Feature -notin $ExistingFeatures)
        {
            try
            {
                Add-WindowsFeature $Feature | Out-Null
                Write-ToLog "Successfully installed $Feature"
            }
            catch
            {
                Write-ToLog "Failed to install $($Feature): $($_.Exception.Message)" -Attention
            }
        }
        else
        {
            Write-ToLog "Feature $Feature already installed"
        }
    }
}

function Disable-IPV6
{
    $Interfaces = (Get-NetAdapter | Where-Object {$_.Status -eq "Up"}).Name
    foreach ($Interface in $Interfaces)
    {
        try
        {
            Disable-NetAdapterBinding -InterfaceAlias $Interface -ComponentID ms_tcpip6
            Write-ToLog "Disabled IPV6 for $Interface"
        }
        catch
        {
            Write-ToLog "Failed to disable IPV6 for $Interface" -Attention
            return
        }
    }
}
function Registry-Fix
{
    Write-ToLog "Adding required registry fixes"
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 72 /f
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f
}
function Add-ADComputerGroups
{
    Write-ToLog "Adding $env:computername to 'NEXT-PLC\eCom_Gold_AD' group"
    $GroupPCName = "NEXT-PLC\$env:computername"+"$"
    ADD-ADGroupMember “NEXT-PLC\eCom_Gold_AD” –members “$GroupPCName"

    Write-ToLog "Adding $env:computername to 'NEXT-PLC\COMP-WSUS-SCCM' group"
    ADD-ADGroupMember “NEXT-PLC\COMP-WSUS-SCCM” –members “$GroupPCName"

    Write-ToLog "Adding $env:computername to 'NEXT-PLC\COMP-Runbook-Patching' group"
    ADD-ADGroupMember “NEXT-PLC\COMP-Runbook-Patching” –members “$GroupPCName"

    Write-ToLog "Adding $env:computername to 'NEXT-PLC\GBL-MoPowered-Web-Servers' group"
    ADD-ADGroupMember “NEXT-PLC\GBL-MoPowered-Web-Servers” –members “$GroupPCName"
}
function Install-DotNet48
{
    Write-ToLog "Installing .NET4.8..."
    cmd.exe /c "C:\Installs\New Server Scripts\Source\ndp48-x86-x64-allos-enu.exe" /q /norestart /ChainingPackage ADMINDEPLOYMENT
}

#### #### #### #### #### #### #### #### ####
####      Build your installs here      ####
#### #### #### #### #### #### #### #### ####

# TEMPLATE #

# $ProgramName = [InstallationInstructions]::New()
# $ProgramName.FullName = "Program Name as it appears in Programs and Features"
# $ProgramName.FilePath = "Path to the installation file"
# $ProgramName.ArgumentList = @(
#     "argument1"
#     "argument2"
# )

#If OS is 2019 install menumanager as stand alone
#Write-ToLog "Installing Menumanager stand alone for 2019"
#If($OSVersion -eq "Windows Server 2019 Standard")
#{
#
#msiexec /i "C:\installs\New Server Scripts\Source\Com+\MenuManager.MSI"
#}

#If OS is 2019 install .net 3.5
#If($OSVersion -eq "Windows Server 2019 Standard")
#{
#Write-ToLog "Installing .Net 3.5 for 2019"
#net use z: \\end-ipmc35\corporate\Sources\WindowsServer2019
#dism /online /enable-feature /featurename:NetFX3 /all /Source:z:\sources\sxs /norestart
#net use z: /delete
#}
#else
#{
#}

##### Regular Installs #####
$location = Read-host -prompt "Is this server at Enderby (e) or Gedding (g)?"

#### Install 2FA Certificae ####
$mypwd = get-credential -UserName 'Enter Certificate Password'   -message 'Enter certificate password below'
import-PfxCertificate -FilePath C:\Installs\mfakvaccess-spn-ecm-prod-exp.pfx -CertStoreLocation Cert:\localmachine\My -Password $mypwd.Password -Exportable
Write-ToLog "Installing 2fa certificate"

#### Remove rogue certificates ####

$servname = $env:computername
$certname = 'CN='+ $servname + '.dmz.next-uk.next.loc'

Write-Output "Certificates Installed:"
Get-ChildItem Cert:\LocalMachine\My

Get-ChildItem Cert:\LocalMachine\My |
Where-Object { $_.'issued to' -contains $certname} | 
Remove-Item

$servname = $env:computername
$certname = 'CN='+ $servname + '.next-uk.next.loc'

Get-ChildItem Cert:\LocalMachine\My |
Where-Object { $_.'issued to' -contains $certname} | 
Remove-Item

Get-ChildItem Cert:\LocalMachine\My
Get-ChildItem Cert:\LocalMachine\My |
Where-Object { $_.subject -eq ''} | 
Remove-Item

write-output "certificates installed:"
Get-ChildItem Cert:\LocalMachine\My


####Configure local admins ####
$localadmin = Read-host  "Enter a name for the local admin"
#$Password = Read-Host -AsSecureString 'Enter local admin password'


do {
Write-Host "Enter local admin password"
$pwd1 = Read-Host "Enter local admin Password for $localadmin" -AsSecureString
$pwd2 = Read-Host "Re-enter Password" -AsSecureString
$pwd1_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pwd1))
$pwd2_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pwd2))
}
while ($pwd1_text -ne $pwd2_text)
Write-Host "Passwords matched"


New-LocalUser $localadmin -Password $pwd1 -Description "Local admin" -passwordneverexpires
Write-ToLog "Creating new local admin $localadmin"
Add-LocalGroupMember -Group "Administrators" -Member $localadmin
Rename-LocalUser -Name "Administrator" -NewName "OldAdmin"
Disable-LocalUser -Name "OldAdmin"
remove-localuser -name "icecube" -ErrorAction:SilentlyContinue
Write-ToLog "Renaming default admin id to oldadmin and disabling"
Remove-LocalGroupMember -Name 'Administrators' -Member next-plc\jagrant  -ErrorAction:SilentlyContinue

#### Add additional local admins ####

Add-LocalGroupMember -Group "Administrators" -Member NEXT-PLC\SVC-PSTEPROD-GRP
Add-LocalGroupMember -Group "Administrators" -Member NEXT-PLC\SVC-Orchestrator-DB
Add-LocalGroupMember -Group "Administrators" -Member NEXT-PLC\USRS-Deployments

####    SCOM    ####
$SCOM               = [InstallationInstructions]::New()
$SCOM.FullName      = "Microsoft Monitoring Agent"
$SCOM.FilePath      = "C:\installs\New Server Scripts\Source\Scom install\AMD64\MOMAgent.msi"
$SCOM.ArgumentList  = @(
    "/q"
    "/i"
    "`"$($SCOM.FilePath)`""
    "NOAPM=1"
    "AcceptEndUserLicenseAgreement=1"
    "MANAGEMENT_SERVER_DNS=end-ipmo15.next-uk.next.loc"
    "MANAGEMENT_GROUP=NEXT-PLC"
    "SECURE_PORT=5723"
)


####    FireEye (Uninstall)    ####
$FireEyeUN              = [InstallationInstructions]::New()
$FireEyeUN.FullName     = "FireEye Endpoint Agent"
$FireEyeUN.FilePath     = "C:\Installs\New Server Scripts\Source\xagtSetup_32.30.0_universal.msi"
$FireEyeUN.ArgumentList = @(
    "/qn"
    "/x"
    "`"$($FireEyeUN.FilePath)`""
    "UNINSTALL_PASSWORD=uU82!JKacupuUv"
)

####    FireEye (Install)    ####
$FireEye                = [InstallationInstructions]::New()
$FireEye.FullName       = "FireEye Endpoint Agent"
$FireEye.FilePath       = "C:\Installs\New Server Scripts\Source\xagtSetup_32.30.0_universal.msi"
$FireEye.ArgumentList   = @(
    "/qn"
    "/i"
    "`"$($FireEye.FilePath)`""
)

####    Dynatrace    ####
$Dynatrace              = [InstallationInstructions]::New()
$Dynatrace.FullName     = "Dynatrace OneAgent"
$Dynatrace.FilePath     = "C:\Installs\New Server Scripts\Source\Dynatrace-OneAgent-Windows.exe"
$Dynatrace.ArgumentList = @(
    "--quiet"
)

####    HP Smart Storage    ####
$HPSmartStorage                 = [InstallationInstructions]::New()
$HPSmartStorage.FullName        = "Smart Storage Administrator"
$HPSmartStorage.FilePath        = "C:\Installs\New Server Scripts\Source\HPE\HPESmartStorageAdmin.exe"
$HPSmartStorage.ArgumentList    = @(
    "/s"
)

####    HP Smart Storage CLI    ####
$HPSmartStorageCLI                 = [InstallationInstructions]::New()
$HPSmartStorageCLI.FullName        = "Smart Storage Administrator CLI"
$HPSmartStorageCLI.FilePath        = "C:\Installs\New Server Scripts\Source\HPE\HPESmartStorageAdminCLI.exe"
$HPSmartStorageCLI.ArgumentList    = @(
    "/s"
)

####    HPE Smart Array Event    ####
$HPSmartArrayEvent                 = [InstallationInstructions]::New()
$HPSmartArrayEvent.FullName        = "HPE Smart Array SR Event Notification Service"
$HPSmartArrayEvent.FilePath        = "C:\Installs\New Server Scripts\Source\HPE\HPESmartArrayEvent.exe"
$HPSmartArrayEvent.ArgumentList    = @(
    "/s"
)

####    HPE Diagnostic Utility    ####
$HPDiagnostic                 = [InstallationInstructions]::New()
$HPDiagnostic.FullName        = "Smart Storage Administrator Diagnostics and SSD Wear Gauge Utility"
$HPDiagnostic.FilePath        = "C:\Installs\New Server Scripts\Source\HPE\HPEDiagnosticUtility.exe"
$HPDiagnostic.ArgumentList    = @(
    "/s"
)

####    HP ILO Config Utility    ####
$HPILOConfig                   = [InstallationInstructions]::New()
$HPILOConfig.FullName          = "HP Lights-Out Online Configuration Utility"
$HPILOConfig.FilePath          = "C:\Installs\New Server Scripts\Source\HPE\HPEILOUtility.exe"
$HPILOConfig.ArgumentList      = @(
    "/s"
)

####    HPE Agentless Management    ####
$HPAgentless                 = [InstallationInstructions]::New()
$HPAgentless.FullName        = "Agentless Management Service"
$HPAgentless.FilePath        = "C:\Installs\New Server Scripts\Source\HPE\AgentlessManagement.exe"
$HPAgentless.ArgumentList    = @(
    "/s"
)

####    HP ILO Cmdlets    ####

$HPILOCmds                  = [InstallationInstructions]::New()
$HPILOCmds.FullName         = "Scripting Tools for Windows Powershell: iLO Cmdlets"
$HPILOCmds.FilePath         = "C:\Installs\New Server Scripts\Source\HPE\HPEiLOCmdlets.msi"
$HPILOCmds.ArgumentList     = @(
    "/qn"
    "/i"
    "`"$($HPILOCmds.FilePath)`""
)

####    IBM WebSphere MQ    ####
$MQ                 = [InstallationInstructions]::New()
$MQ.FullName        = "IBM WebSphere MQ (Installation1)"
$MQ.FilePath        = "C:\Installs\New Server scripts\Source\IBM\MQClient\NX100629\windows\msi\IBM WebSphere MQ.msi"
$MQ.ArgumentList    = @(
    "/qn"
    "/i"
    "`"$($MQ.FilePath)`""
    "AGREETOLICENSE=1"
    "LAUNCHWIZ=0"
)

####    Qualys    ####
$Qualys                 = [InstallationInstructions]::New()
$Qualys.FullName        = "Qualys Cloud Security Agent"
$Qualys.FilePath        = "C:\Installs\New Server Scripts\Source\Qualys Cloud Agent - eCommerce - VLAN101\QualysCloudAgent.exe"
$Qualys.ArgumentList    = @(
    "CustomerId={b546b3c8-4cff-53eb-e040-18ac09046184}"
    "ActivationId={00b704f0-1c06-4a15-91db-ee11d39899ff}"
)

####    Qualys Proxy Config    ####
$QualysProxy                = [InstallationInstructions]::New()
$QualysProxy.FullName       = "Qualys Proxy"
$QualysProxy.FilePath       = "C:\Program Files\Qualys\QualysAgent\QualysProxy.exe"
$QualysProxy.ArgumentList   = @(
    "/u http://101.10.145.240:9091"
)
$QualysProxy.IgnoreValidation = $true

####    Snow Inventory Agent    ####
$Snow               = [InstallationInstructions]::New()
$Snow.FullName      = "Snow Inventory Agent"
$Snow.FilePath      = "C:\installs\New Server Scripts\Source\Snow Agent\NextWindowsServer-April2023.msi"
$Snow.ArgumentList  = @(
    "/q"
    "/i"
    "`"$($Snow.FilePath)`""
)
$Snow.AdditionalScript = 'Copy-Item "C:\installs\New Server Scripts\Source\Snow Agent\snowagent.config" -Destination "C:\Program Files\Snow Software\Inventory\Agent\snowagent.config"'

##### COM+ Applications #####

####    InternetMQ    ####
$InternetMQ          = [InstallationInstructions]::New()
$InternetMQ.FullName = "InternetMQ"
$InternetMQ.FilePath = "C:\Installs\New Server Scripts\Source\Com+\InternetMQ.MSI"

####    MenuManager    ####
$MenuManager          = [InstallationInstructions]::New()
$MenuManager.FullName = "MenuManager"
$MenuManager.FilePath = "C:\Installs\New Server Scripts\Source\Com+\MenuManager.MSI"

####    runmqdnm    ####
$runmqdnm          = [InstallationInstructions]::New()
$runmqdnm.FullName = "runmqdnm"
$runmqdnm.FilePath = "C:\Installs\New Server Scripts\Source\Com+\runmqdnm.MSI"


#### #### #### #### #### #### #### #### ####
####        Execution begins here       ####
#### #### #### #### #### #### #### #### ####

# Copy the files to the server (overwrites existing)
#Copy-Item "\\end-ipmc35\Corporate\eCommerce\New Server Scripts" -Destination "C:\Installs" -Recurse -Force

# Install Main Applications
Install-Program $FireEyeUN
Install-Program $FireEye
Install-Program $SCOM
Install-Program $MQ
Install-Program $Qualys
Install-Program $QualysProxy
Install-Program $Snow



# Install other apps/apply fixes
Set-FoldersAndShares
# COMMENTED .net 3.5 out as preinstalled in WIM images for 2016 and 2019. 15/3/23. Reinstated 31/3
Install-DotNET35
Install-RolesAndFeatures
Uninstall-SilverLight
Enable-RDP
Enable-Remoting
Install-LogClearDownTask
#Set-MainframeRoutes
Update-ServerID
Install-SMBSigningFix
Disable-IPV6
Invoke-OneLiners
Registry-Fix
#Add-ADComputerGroups
Install-DotNet48

#### Physical Machine Specific Configs ####
if ((Get-ComputerPlatform).Platform -eq "Physical")
{
    Install-Program $HPSmartStorage
    Install-Program $HPSmartStorageCLI
    Install-Program $HPILOCmds
    Install-Program $HPILOConfig
    Install-Program $HPSmartArrayEvent
    Install-Program $HPDiagnostic
    Install-Program $HPAgentless
    Write-ToLog "Copying machine.config"
    Copy-Item -Path "C:\Installs\New Server Scripts\Source\.NET Config\machine.config" -Destination "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\machine.config" -Force
if(-not $?) {write-warning "Copy Failed"}
else {write-host "Succes"} }





#Install .net patch - MNICE
Write-ToLog "Installing .net patch"
Start-Process -wait wusa -ArgumentList "/update c:\installs\DN\windows10.0-kb5017035-x64-ndp48_be1647f3ef227d05c2b120433b34b58998af32ea.msu","/quiet","/norestart"
Write-ToLog "Reboot required to complete .net patch installation"

#Configure Static Routes - MNICE
Write-ToLog "Configuring Persistent Routes"
#$location = Read-host -prompt "Is this server at Enderby (e) or Gedding (g)?"
route -p delete 194.169.114.0 2>$null
route -p delete 192.168.210.0 2>$null
route -p delete 194.36.12.139 2>$null
route -p delete 194.36.12.141 2>$null

#If server is physical and at Enderby, install Rubrik with Enderby config
if ((Get-ComputerPlatform).Platform -eq "Physical" -and $location -eq 'e')
{
start-sleep -seconds 20
Echo "Intalling Rubrik and configuring for Enderby"

msiexec /i "C:\installs\Rubrik\Enderby\RubrikBackupService.msi" /quiet

start-sleep -seconds 20

Get-Service -Name "Rubrik Backup Service" | restart-Service -Force

}


#If server is physical and at Gedding, install Rubrik with Gedding config
if ((Get-ComputerPlatform).Platform -eq "Physical" -and $location -eq 'g')
{
start-sleep -seconds 20
Echo "Intalling Rubrik and configuring for Gedding"

msiexec /i "C:\installs\Rubrik\GeddingRoad\RubrikBackupService.msi" /quiet

start-sleep -seconds 20

Get-Service -Name "Rubrik Backup Service" | restart-Service -Force
}

start-sleep -seconds 60

If ($location -eq 'e') {
Echo "Setting Static routes for Enderby"
route add 194.169.114.0 mask 255.255.255.0 101.10.109.1 metric 1 /p
route add 194.169.114.0 mask 255.255.255.0 101.10.109.5 metric 10 /p
route add 192.168.210.0 mask 255.255.255.0 101.10.109.1 metric 1 /p
route add 192.168.210.0 mask 255.255.255.0 101.10.109.5 metric 1 /p
route add 194.36.12.139 mask 255.255.255.0 101.10.109.1 metric 1 /p
route add 194.36.12.139 mask 255.255.255.0 101.10.109.5 metric 1 /p
route add 194.36.12.141 mask 255.255.255.0 101.10.109.1 metric 1 /p
route add 194.36.12.141 mask 255.255.255.0 101.10.109.5 metric 1 /p

} else  {
Echo "Setting Static routes for Gedding"
route add 194.169.114.0 mask 255.255.255.0 101.10.109.1 metric 10 /p
route add 194.169.114.0 mask 255.255.255.0 101.10.109.5 metric 1 /p
route add 192.168.210.0 mask 255.255.255.0 101.10.109.1 metric 1 /p
route add 192.168.210.0 mask 255.255.255.0 101.10.109.5 metric 1 /p
route add 194.36.12.139 mask 255.255.255.0 101.10.109.1 metric 1 /p
route add 194.36.12.139 mask 255.255.255.0 101.10.109.5 metric 1 /p
route add 194.36.12.141 mask 255.255.255.0 101.10.109.1 metric 1 /p
route add 194.36.12.141 mask 255.255.255.0 101.10.109.5 metric 1 /p


}



#### Production Only Configs ####
#if ($Environment -eq "Prod")
#{
#echo "Installing Dynatrace"
#    Install-Program $Dynatrace
#}

#### Change everyone permissions on share Inetpub from full to read ####
echo "Setting everyone read access on inetpub% share"
grant-smbshareaccess -name inetpub$ -accountname everyone -accessright read -force

#### Install COM+ Objects ####
Install-COMPlusApplication -Applications @($InternetMQ,$runmqdnm,$MenuManager)

#### Give eCommerce permission to read the Event Log ####
echo "Adding group NEXT-PLC\USRS-eCommerce to Event Log Readers" 
Add-LocalGroupMember -Group "Event Log Readers" -Member "NEXT-PLC\USRS-eCommerce" 

#### Set W3SVC to delayed start - also referred to as "the W3SVC patch" ####
echo "Starting the W3SVC service and setting to delayed start"
cmd.exe /c 'sc config W3SVC start= delayed-auto'
#cmd.exe /c 'net start W3SVC'

#### Removing IE ####
Echo "Removing IE"
Disable-WindowsOptionalFeature -featurename Internet-explorer-optional-amd64 -Online -norestart

#If OS is 2019 install menumanager as stand alone
#Write-ToLog "Installing Menumanager stand alone for 2019"
#If($OSVersion -eq "Windows Server 2019 Standard")
#{
#
#msiexec /i "C:\installs\New Server Scripts\Source\Com+\MenuManager.MSI"
#}

## Disable unused NIC's ##

Write-Host "Disabling all disconnected Nic's..." -ForegroundColor Green

    Get-NetAdapter | select Name, InterfaceDescription, ifIndex, Status, MacAddress, LinkSpeed | where { $_.Status -ne 'up' -or $_.LinkSpeed -ne '10 Gbps' } | Disable-NetAdapter -Confirm:$false

 $enabled_nics = Get-NetAdapter | select Name, InterfaceDescription, ifIndex, Status, MacAddress, LinkSpeed | where { $_.Status -eq 'up' }
  
## Create NIC Team ##
   
Write-Host Creating NIC Team using $enabled_nics.Name -ForegroundColor Green
   
   New-NetLbfoTeam -Name "Team" -TeamMembers $enabled_nics.Name -Confirm:$false

 Write-Host "Waiting for 15 seconds while NIC Team is setup..." -ForegroundColor Yellow
 Start-Sleep -Seconds 15

    $team = Get-NetAdapter | select Name, ifIndex | where { $_.Name -eq 'Team' }
    $primary_ip = Read-Host "Enter Primary IP address here..."


## Setting static IP's ##

Write-Host Setting $primary_ip to $team.Name -ForegroundColor Magenta

    New-NetIPAddress -InterfaceIndex $team.ifIndex -IPAddress $primary_ip -AddressFamily IPv4 -PrefixLength 16 -DefaultGateway 101.10.10.3

 
## Set DNS settings ## 
 
$DNS_Servers = "172.28.65.39" , "172.28.65.37" , "172.28.64.26" , "172.28.64.25" | Get-Random -Count 4
$shuffled_dns = $DNS_Servers | Sort-Object {Get-Random}

 
Write-Host Setting $shuffled_dns to $team.Name -ForegroundColor Magenta
    
    Set-DnsClientServerAddress -InterfaceIndex $team.ifIndex -ServerAddresses $shuffled_dns

$secondary_ip_prompt = Read-Host "Enter Secondary IP Address Here..."
$secondary_ip = $secondary_ip_prompt + '/16'

Write-Host Setting $secondary_ip to $team.Name -ForegroundColor Magenta

    .\netsh.exe int ipv4 add address $team.Name $secondary_ip skipassource=true

    .\netsh.exe int ipv4 show ipaddresses level=verbose


## Setting DNS Suffixes ##

Write-Host Adding DNS suffixes to $team.Name -ForegroundColor Green

        Set-DnsClientGlobalSetting -SuffixSearchList @("dmz.next-uk.next.loc", "next-uk.next.loc", "next.loc")


## Disable LMHOSTS lookup ##

Write-Host Disabling LMHOSTS lookup -ForegroundColor Green

    $DisableLMHosts_Class=Get-WmiObject -list Win32_NetworkAdapterConfiguration
    $DisableLMHosts_Class.EnableWINS($false,$false)


## Disable NetBIOS over TCP/IP ##

Write-Host Disabling NetBIOS over TCP/IP on $team.Name -ForegroundColor Green

    $NETBIOS_DISABLED=2

        Get-WmiObject Win32_NetworkAdapterConfiguration -filter "ipenabled = 'true'" | ForEach-Object { $_.SetTcpipNetbios($NETBIOS_DISABLED)}


## Reg fix for Duo on DMZ ##

write-Host "Adding DUO reg keys..." -ForegroundColor Green

    Reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Duo Security\DUOCredProv" /v HttpProxyHost /d 101.10.145.240 /t REG_SZ
    Reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Duo Security\DUOCredProv" /v HttpProxyPort /d 9090 /t REG_DWORD


## Check machine.config has updated and is correct ##

Write-Host "Copying config file to .Net folder..." -ForegroundColor Green

    Copy-Item -Path "C:\Installs\New Server Scripts\Source\.NET Config\machine.config" -Destination "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\machine.config" -Force

     
     
     
     Write-Host "   Reboot system after running script to ensure changes take affect   " -ForegroundColor Blue -BackgroundColor White                              
  


Write-ToLog "Errors found: $ErrCount"