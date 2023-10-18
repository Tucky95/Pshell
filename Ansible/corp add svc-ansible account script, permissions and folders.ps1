#############################################################################################################
#                                                                                                           #
#            Configure vCenter Role, Permissions and assign to svc-ansible to allow Ansible                 #
#            to connect to it to permorm certain function such as clone vm and build Templates              #
#            Also creates the Folder structure agreed for the Templates to be stored.                       #
#            {Datacentre}\Templates\Ansible                                                                 #
#                                                                                                           #
#            Note: There is no way to add a description of the role via code so this will need to be        #
#            done after the script is ran.                                                                  #
#            Description to be added: Role to allow control of VMs by Ansible                               #
#                                                                                                           #
#            References:                                                                                    #
#            https://notesofascripter.com/2021/12/28/export-vcenter-roles-and-permissions-with-powercli/    #
#            https://vdc-download.vmware.com/vmwb-repository/dcr-public/b34705db-95be-4221-8afd-300c9398532c/e93e6337-ccb3-42f8-9325-e01f43c8eb67/doc/GUID-D3A52C58-4A37-41C5-9D2A-7DCB8A6FB206.html#:~:text=With%20PowerCLI%2C%20you%20can%20automate,permissions%2C%20roles%2C%20and%20privileges.&text=vSphere%20permissions%20determine%20your%20level,are%20predefined%20sets%20of%20privileges.
#            https://communities.vmware.com/t5/VMware-PowerCLI-Discussions/How-to-check-if-an-folder-exists/td-p/364897
#                                                                                                           #
#                                                                                                           #
#############################################################################################################


$Username = Read-Host "Username:"
$Password = Read-Host "Password:" -AsSecureString
$vCenter = Read-Host "vCenter Server:"
$DataCenter = Read-Host "Datacenter:"

#Connect to vCenter
$SecureCredential = New-Object System.Management.Automation.PSCredential -ArgumentList $Username, $Password
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false
Connect-VIServer -Server $vCenter -User $SecureCredential.UserName -Password ([Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureCredential.Password)))

$RoleCheck = Get-VIRole -Name "Ansible VM management role" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
if($RoleCheck){
    Write-Host "Role alrady exists. Skipping Role Creation." -BackgroundColor Red


}else{
    #Configure Role for svc-ansible

    $Role = New-VIRole -Name "Ansible VM management role" 
    $privilege = Get-content "D:\Ansible\vCenter_Preparation\svc-ansible-privileges.txt"
    $privilege | foreach {Set-VIRole -role $role -AddPrivilege (get-viprivilege -id $_)}
   
   <# #Adapted from https://vdc-download.vmware.com/vmwb-repository/dcr-public/b34705db-95be-4221-8afd-300c9398532c/e93e6337-ccb3-42f8-9325-e01f43c8eb67/doc/GUID-D3A52C58-4A37-41C5-9D2A-7DCB8A6FB206.html#:~:text=With%20PowerCLI%2C%20you%20can%20automate,permissions%2C%20roles%2C%20and%20privileges.&text=vSphere%20permissions%20determine%20your%20level,are%20predefined%20sets%20of%20privileges. 
   #>
    
    #Create a permission and apply it to a vSphere root object.
    $rootFolder = Get-Folder -NoRecursion
    $permission1 = New-VIPermission -Entity $rootFolder -Principal "next-plc\svc-ansible" -Role "Ansible VM management role" -Propagate:$true | Out-Null
}



#Create Ansible Templates Folder
#Check for Templates Folder
$foldername = "Templates"
$data = get-folder -Type VM | Where-Object {$_.name -eq $foldername}
if ($data -eq $null) {
    Write-Host "$foldername Folder doesn't exist. Creating." -BackgroundColor Red
    $Datacenter = $DataCenter
    (Get-View (Get-View -viewtype datacenter –filter @{"name"=$Datacenter}).vmfolder).CreateFolder($foldername)
}
else {
    Write-Host "$foldername Folder exists" -BackgroundColor DarkGreen
}

#Check for Ansible Folder
$foldername = "Ansible"
$data = get-folder -Type VM | Where-Object {$_.name -eq $foldername}
if ($data -eq $null) {
    Write-Host "$foldername Folder doesn't exist. Creating." -BackgroundColor Red
    $Datacenter = $DataCenter
    New-Folder -Name $foldername -Location "Templates"
}
else {
    Write-Host "$foldername Folder exists" -BackgroundColor DarkGreen
}
