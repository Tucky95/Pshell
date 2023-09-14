
$Name = Get-ComputerInfo |select CsCaption
    # Get the name of the system and save to a variable

$get = Get-NetIPConfiguration  | Select @{ n='Name' ; e={@($Name.CsCaption)}}, 'InterfaceIndex' , @{ n='DNSServer' ; e={@($_.DNSServer.ServerAddresses)}}
    # Get DNS server settings. Then combine the output with the name variable. Has to translate to readable string

$get | Export-Csv "C:\installs\dns_script\dns_demotion\dns_index_output.csv" -NoTypeInformation
    # Output the results into a csv file
