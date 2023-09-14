
# get iis version
C:\PSTOOLS\PSexec.exe \\end-epws462 powershell.exe -command "& {get-itemproperty HKLM:\SOFTWARE\Microsoft\InetStp\  | select setupstring}"


C:\PSTOOLS\PSexec.exe \\end-epas109 powershell.exe -command "& {Get-ItemProperty 'HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full' |Select version, release}"

#(Get-ItemProperty -path c:\psexec.exe).CreationTime;

# get .net version
C:\PSTOOLS\PSexec.exe \\end-epws304 powershell.exe -command "& {Get-ItemProperty 'HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full' |Select version, release}"