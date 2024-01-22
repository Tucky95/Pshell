$dmzcomputer = (Get-ADComputer -Filter 'operatingsystem -like "server"' -SearchBase $OUpath2 -Server "dmz.next-uk.next.loc" -SearchScope Subtree | Select-object Name).Name
$corpcomputer = (Get-ADComputer -Filter 'operatingsystem -like "server"' -SearchBase $OUpath1 -SearchScope Subtree | Select-object Name).Name



    Get-ADGroup -Identity "COMP-Servers-DisableLLMNR" -SearchBase "OU=Security,OU=_NextDMZ Groups,OU=Servers,OU=NextDMZ,DC=dmz,DC=next-uk,DC=next,DC=loc" -Server "dmz.next-uk.next.loc" -SearchScope Subtree #| Select-object Name

    Get-ADGroup -Server "dmz.next-uk.next.loc" -Filter "Name -eq 'COMP-Servers-DisableLLMNR'" -SearchBase "OU=Security,OU=_NextDMZ Groups,OU=Servers,OU=NextDMZ,DC=dmz,DC=next-uk,DC=next,DC=loc" | Get-ADGroupMember Select-object Name