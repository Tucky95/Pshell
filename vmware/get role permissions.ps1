
#Add the PowerOn privileges to the new role.

$powerOnPrivileges = Get-VIPrivilege -Name "ContentLibrary.CheckInTemplate"
$role1 = Set-VIRole –Role $role1 –AddPrivilege $powerOnPrivileges


Get-VIRole -Name "Ansible VM management role"


    Get-VIPrivilege -Name "ContentLibrary.CheckInTemplate"

    Get-VIPrivilege -Name "Check in a template"