
## Run as admin
### Ensure ciphers_export folder has been copied to 

<# 

 This script will check for the presence of the below cipher registry keys.
 If they are missing, they will be imported from the ciphers_export folder
 

#> 




    $ErrorActionPreference = 'SilentlyContinue'

$AES128 = Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\AES 128/128'
$AES256 = Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\AES 256/256'
$DES56 = Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\DES 56/56'
$NULL = Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\NULL'
$RC2128 = Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 128/128'
$RC240 = Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 40/128'
$RC256 = Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 56/128'
$RC4128 = Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128'
$RC440 = Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128'
$RC456 = Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128'
$RC464 = Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 64/128'
$TripleDES168 = Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168'


if ( $AES128 -eq 'True' ) { Write-Host "AES 128/128 Registry Present" -ForegroundColor Green }

    else { Write-Host "AES 128/128 key empty" -ForegroundColor Yellow
    
    
    Write-Host "Creating AES 128/128 key..." -ForegroundColor Cyan

        reg import 'C:\installs\PostBuildScript\eCommercePS\ciphers_export\AES 128128.reg'


            Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\AES 128/128\'   
      
    
     }


if ( $AES256 -eq 'True' ) { Write-Host "AES 256/256 Registry Present" -ForegroundColor Green }

    else { Write-Host "AES 256/256 key empty" -ForegroundColor Yellow
    
    
    Write-Host "Creating AES 256/256 key..." -ForegroundColor Cyan

        reg import 'C:\installs\PostBuildScript\eCommercePS\ciphers_export\AES 256256.reg'


            Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\AES 256/256'   
      
    
     }


if ( $DES56 -eq 'True' ) { Write-Host "DES 56/56 Registry Present" -ForegroundColor Green }

    else { Write-Host "DES 56/56 key empty" -ForegroundColor Yellow
    
    
    Write-Host "Creating DES 56/56 key..." -ForegroundColor Cyan

        reg import 'C:\installs\PostBuildScript\eCommercePS\ciphers_export\DES 5656.reg'


            Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\DES 56/56'  
      
    
     }



if ( $NULL -eq 'True' ) { Write-Host "NULL Registry Present" -ForegroundColor Green }

    else { Write-Host "NULL key empty" -ForegroundColor Yellow
    
    
    Write-Host "Creating NULL key..." -ForegroundColor Cyan

        reg import C:\installs\PostBuildScript\eCommercePS\ciphers_export\NULL.reg


            Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\NULL'
      
    
     }


if ( $RC2128 -eq 'True' ) { Write-Host "RC2 128/128 Registry Present" -ForegroundColor Green }

    else { Write-Host "RC2 128/128 key empty" -ForegroundColor Yellow
    
    
    Write-Host "Creating RC2 128/128 key..." -ForegroundColor Cyan

        reg import 'C:\installs\PostBuildScript\eCommercePS\ciphers_export\RC2 128128.reg'


            Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 128/128'
      
    
     }


if ( $RC240 -eq 'True' ) { Write-Host "RC2 40/128 Registry Present" -ForegroundColor Green }

    else { Write-Host "RC2 40/128 key empty" -ForegroundColor Yellow
    
    
    Write-Host "Creating RC2 40/128 key..." -ForegroundColor Cyan

        reg import 'C:\installs\PostBuildScript\eCommercePS\ciphers_export\RC2 40128.reg'


            Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 40/128'
      
    
     }


if ( $RC256 -eq 'True' ) { Write-Host "RC2 56/128 Registry Present" -ForegroundColor Green }

    else { Write-Host "RC2 56/128 key empty" -ForegroundColor Yellow
    
    
    Write-Host "Creating RC2 56/128 key..." -ForegroundColor Cyan

        reg import 'C:\installs\PostBuildScript\eCommercePS\ciphers_export\RC2 56128.reg'


            Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 56/128'
      
    
     }


if ( $RC4128 -eq 'True' ) { Write-Host "RC4 128/128 Registry Present" -ForegroundColor Green }

    else { Write-Host "RC4 128/128 key empty" -ForegroundColor Yellow
    
    
    Write-Host "Creating RC4 128/128 key..." -ForegroundColor Cyan

        reg import 'C:\installs\PostBuildScript\eCommercePS\ciphers_export\RC4 128128.reg'


            Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128'
      
    
     }



if ( $RC440 -eq 'True' ) { Write-Host "RC4 40/128 Registry Present" -ForegroundColor Green }

    else { Write-Host "RC4 40/128 key empty" -ForegroundColor Yellow
    
    
    Write-Host "Creating RC4 40/128 key..." -ForegroundColor Cyan

        reg import 'C:\installs\PostBuildScript\eCommercePS\ciphers_export\RC4 40128.reg'


            Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128'
      
    
     }



if ( $RC456 -eq 'True' ) { Write-Host "RC4 56/128 Registry Present" -ForegroundColor Green }

    else { Write-Host "RC4 56/128 key empty" -ForegroundColor Yellow
    
    
    Write-Host "Creating RC4 56/128 key..." -ForegroundColor Cyan

        reg import 'C:\installs\PostBuildScript\eCommercePS\ciphers_export\RC4 56128.reg'


            Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128'
      
    
     }



if ( $RC464 -eq 'True' ) { Write-Host "RC4 64/128 Registry Present" -ForegroundColor Green }

    else { Write-Host "RC4 64/128 key empty" -ForegroundColor Yellow
    
    
    Write-Host "Creating RC4 64/128 key..." -ForegroundColor Cyan

        reg import 'C:\installs\PostBuildScript\eCommercePS\ciphers_export\RC4 64128.reg'


            Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 64/128'
      
    
     }



if ( $TripleDES168 -eq 'True' ) { Write-Host "Triple DES 168 Registry Present" -ForegroundColor Green }

    else { Write-Host "Triple DES 168 key empty" -ForegroundColor Yellow
    
    
    Write-Host "Creating Triple DES 168 key..." -ForegroundColor Cyan

        reg import 'C:\installs\PostBuildScript\eCommercePS\ciphers_export\Triple DES 168.reg'


            Test-Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168'
      
    
     }