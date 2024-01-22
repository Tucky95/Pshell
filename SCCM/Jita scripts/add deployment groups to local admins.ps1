
# Adds the "on system" accounts from JITA to the Local Admins group on the server

Add-LocalGroupMember -Group "Administrators" -Member "NEXT-PLC\SVC-Orchestrator-DB"

Add-LocalGroupMember -Group "Administrators" -Member "NEXT-PLC\SVC-PSTEPROD-GRP"

Add-LocalGroupMember -Group "Administrators" -Member "NEXT-PLC\USRS-Deployments"

Add-LocalGroupMember -Group "Administrators" -Member "NEXT-PLC\USRS-SupportLevel1"

Add-LocalGroupMember -Group "Administrators" -Member "NEXT-PLC\SVC-s1_protect"

Add-LocalGroupMember -Group "Administrators" -Member "DMZ\SVC-s1_protect"