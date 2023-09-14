C:\PSTOOLS\PSexec.exe \\end-epws1041 powershell.exe -command "& {Get-DnsClientServerAddress | Select-Object -ExpandProperty ServerAddresses}" -nobanner


\\$server -h -d powershell.exe -command "& { wmic qfe list }"


C:\PSTOOLS\PSexec.exe \\end-epws120 powershell.exe -command "& {  wmic qfe list | FT caption, csname, description, hotfixid, installdate, installedby, installedon  | out-file \\END-ICE-GRF\c$\Temp\output\wmic_qfe_list.csv }" -nobanner

Get-NetIPConfiguration