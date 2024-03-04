
$cluster = "end-epvh19-cluster"
$Server = "end-epvc01.next-uk.next.loc"
$username = "administrator@vsphere.local"
$pw = "Wibble123!"
$csv = Import-Csv "C:\CSV\edas_vms_list.csv"


Connect-VIServer -Server $Server -Protocol https -User $username -Password $pw

#Set-PowerCLIConfiguration -InvalidCertificateAction "ignore"

Get-VM -Name "end-edas04"

Get-DrsClusterGroup -VM END-EDAS04, END-EDAS05, END-ASSQ01-OLD, END-ASAS02 | select Name, Member

Get-DrsClusterGroup -VM END-ASAS02 | select Name, Member

Get-DrsRule -Cluster $cluster -VM END-ASAS02

Set-DrsRule -Rule $gedding_drs_rule -VM "end-edas04" -Enabled $true

Get-Help Set-DrsRule -Examples

Set-DrsClusterGroup $gedding_dev_drs_rule -VM "end-edas04" -Add

Set-DrsClusterGroup $gedding_dev_drs_rule -VM "end-edas04" -Remove

Remove-DrsClusterGroup -DrsClusterGroup -v