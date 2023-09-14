   
   ## next.loc group not working

#Variables    

    $dmz = "dmz.next-uk.next.loc"
    $group_search_base = "OU=Security,OU=_NextDMZ Groups,OU=Servers,OU=NextDMZ,DC=dmz,DC=next-uk,DC=next,DC=loc"
    $server_search_base = "OU=Web Servers,OU=Live,OU=Servers,OU=eCommerceDMZ,DC=dmz,DC=next-uk,DC=next,DC=loc"
    
    $group1 = 'COMP-Servers-DisableLLMNR'
    $group2 = 'COMP-WSUS-SCCM'

        $corp_group_prams = @{
    
            Identity = "CN=eComm_Gold_AD,OU=_eCommerce,OU=Servers,OU=End,OU=Computers,OU=NextPLC,DC=next-uk,DC=next,DC=loc"
            Server = 'next-uk.next.loc'
            }

        $user_Params = @{
        
            Identity = 'CN=END-EPWS6114,OU=Web Servers,OU=Live,OU=Servers,OU=eCommerceDMZ,DC=dmz,DC=next-uk,DC=next,DC=loc'
            Server = "dmz.next-uk.next.loc"
        
        
        }
        $server = Get-ADComputer $user_Params
    
    $server_name = Read-Host "Enter Server Name Here..."
    $sam_acc_name = $server_name  + "$"
    
    
    
    
    Get-ADGroup $corp_group_prams
    Get-ADComputer -Identity $sam_acc_name -Server $dmz

    $gold_group = Get-ADGroup -Identity "eComm_Gold_AD" -Server "next-uk.next.loc"

    
        Add-ADGroupMember -Identity $group1 -Members $sam_acc_name -Server $dmz
        
        Add-ADGroupMember -Identity $group2 -Members $sam_acc_name -Server $dmz

        Add-ADGroupMember -Identity next-uk.next.loc -Members $sam_acc_name -Server $dmz

    
    Get-ADGroupMember -Identity $group1 -Server $dmz | Select Name

    Get-ADGroupMember -Identity $group2 -Server $dmz | Select Name