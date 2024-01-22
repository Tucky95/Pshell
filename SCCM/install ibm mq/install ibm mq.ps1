## Delete any reg keys referencing M drive before running this script
### HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders
#### HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders

## This is extracted from the post build script and only installs the IBM MQ listener service

## https://support.techsmith.com/hc/en-us/articles/203730238-Error-1327-Invalid-Drive-Error-When-Installing


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


Install-Program $MQ