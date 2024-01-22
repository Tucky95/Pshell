# Run this on a jump box that is on the domain


Import-Module ActiveDirectory

$AllSPNsObjects = Get-ADObject -Filter "(objectClass -eq 'user') -and (objectClass -eq 'computer')" -Properties sAMAccountName, servicePrincipalName | Where-Object servicePrincipalName -ne $null
$SPNArray = @()
  
foreach ($SPNObject in $AllSPNsObjects)
{
   $SamAccountName = $SPNObject.SamAccountName
   $ServicePrincipalNames = $SPNObject.ServicePrincipalName
  
   foreach ($ServicePrincipalName in $ServicePrincipalNames)
   {
        if ($SPNArray.ServicePrincipalName -like "$ServicePrincipalName")
        {
            $MatchedSPNs = $SPNArray.ServicePrincipalName -like "$ServicePrincipalName"
            foreach ($MatchSPN in $MatchedSPNs)
            {
                $MatchSamAccountName = $MatchSPN.SamAccountName
                if ($MatchSamAccountName -ne $SamAccountName)
                {
                   Write-Error "Duplicated SPN has been found for $ServicePrincipalName!!!"
                }
            }
        }
        else
        {
            $Properties =  @{
                "SamAccountName" = $SamAccountName
                "ServicePrincipalName" = $ServicePrincipalName
            }
       
             $SPNArrayRow = New-Object PSObject -Property $Properties
             $SPNArray += $SPNArrayRow
        }
   }
}