
$get_tag_members = Get-TagAssignment -Category "Site Tags Category" -ErrorAction Ignore
$tag_name =  $get_tag_members.Tag | Select Name
$entity = $get_tag_members.entity | Select Name

    foreach ( $member in $get_tag_members ) {


        

        
        if ( $tag_name -is "VM_Tag_Gedding" ) { Write-Host "$member" will be added to gedding vm tag  }

        if ( $tag_name -is "VM_Tag_Enderby" ) { Write-Host "$member" will be added to enderby vm tag  }









        }




<# 

*****JUNK COMMANDS*******

Get-VM -Name "end-edas09" -Tag

Get-vm "end-edas09" | get-member

Get-VM -Name "end-edas09" | Fl

Get-Tag -Name "VM_Tag_Enderby" | FL

Get-TagAssignment -Tag "VM_Tag_Enderby" | select Tag, Entity

Get-TagAssignment -Tag $gedding_vm_tag

Get-TagAssignment -Category "Site Tags Category"

Get-TagCategory -Name "Site Tags Category"

Get-VM "END-EDAS06" | New-TagAssignment -Tag $gedding_vm_tag

New-TagAssignment -Entity "end-edas09" -Tag $gedding_vm_tag


#>