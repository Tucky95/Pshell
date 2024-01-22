        $local_groups = Get-WMIObject Win32_Group | Where-Object { $_.Domain -contains $env:computername } | Select Name

        
        Write-Host "9.local group members.txt " -ForegroundColor Green

            foreach ( $group in $local_groups) {

                $members = net localgroup $group.Name
                $members | Out-File "$audit_folder\9.local group members - $server.txt" -Append }