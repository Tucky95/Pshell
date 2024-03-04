
Connect-VIServer -Server end-epvc01.next-uk.next.loc -Protocol https -User administrator@vsphere.local -Password Wibble123!


Set-PowerCLIConfiguration -InvalidCertificateAction "ignore"

Get-Cluster -Name "end-epvh19-cluster"

Get-DrsRule -Cluster "end-epvh19-cluster"

Get-Cluster -Name "end-epvh19-cluster" | Get-DrsRule

Get-DrsClusterGroup -Cluster "end-epvh19-cluster" -Type VMHostGroup | FT

get-drsclustergroup -Type VMGroup -cluster "end-epvh19-cluster" -Name "Enderby VMs" | Select -ExpandProperty Member | Select Name | Export-Csv "C:\CSV\enderby_vm_drs_rule.csv"

get-drsclustergroup -Type VMGroup -cluster "end-epvh19-cluster" -Name "Gedding VMs" | Select -ExpandProperty Member | Select Name | Export-Csv "C:\CSV\gedding_vm_drs_rule.csv"

get-drsclustergroup -Type VMGroup -cluster "end-epvh19-cluster" -Name "Enderby DEV/UAT VMs" | Select -ExpandProperty Member | Select Name

get-drsclustergroup -Type VMGroup -cluster "end-epvh19-cluster" -Name "Gedding DEV/UAT VMs" | Select -ExpandProperty Member | Select Name

Get-VMHost "end-epvh19-cl01.next-uk.next.loc"

Get-VM -Location "end-epvh19-cluster" | Select Name | Export-Csv "C:\CSV\all_epvh19_vms.csv"