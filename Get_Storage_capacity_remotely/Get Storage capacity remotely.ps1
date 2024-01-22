
get-WmiObject win32_logicaldisk -Computername end-epws255,end-epws256, END-EPWS257, END-EPWS258, END-EPWS455, END-EPWS456, END-EPWS457 , END-EPWS458 | Select PScomputerName ,DeviceID, {$_.Size /1GB}, {$_.FreeSpace /1GB} , VolumeName | Export-Csv C:\SCRIPTS\!NEXT_SCRIPTS\capacity_report.csv -NoTypeInformation

#get-WmiObject win32_logicaldisk -Computername end-epws255 | Select PScomputerName, DeviceID, {$_.FreeSpace /1GB} , {$_.Size /1GB} , VolumeName

