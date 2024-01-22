
#Mo's script
$Hostname= "END-EPSQ31-VS04"
$IPAdd= '172.28.13.10'
Add-ipamaddress -ipaddress $IPAdd -Description $Hostname -ManagedByService 'IPAM' -ServiceInstance 'localhost'`-DeviceType 'host' -IpAddressState 'In-Use' -AssignmentType 'dynamic' -DeviceName $Hostname -Owner 'ICE' -NetworkType NonVirtualized


#Swapnil's script
Invoke-Command {Add-IpamAddress -IpAddress <Your IP address>} -ComputerName END-IPDI05

Invoke-Command {Set-IpamAddress -IpAddress <Your IP address> -DeviceName "<Your device name>"} -ComputerName END-IPDI05
Invoke-Command {Set-IpamAddress -IpAddress <Your IP address>  -Description "<Your device name>"} -ComputerName END-IPDI05

And additionally, below is use to find if address is free or not  


Invoke-Command {Get-IpamAddress  -IpAddress <Your IP address to find>} -ComputerName END-IPDI05