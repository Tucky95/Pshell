

Get-ChildItem cert:\LocalMachine\My | Where-Object {$_.Subject -contains "CN=mfakvaccess-spn-ecm-prod, OU=ICE / Ecommerce, O=Next-PLC, L=Leicester, S=Leicestershire, C=GB"} | Remove-Item