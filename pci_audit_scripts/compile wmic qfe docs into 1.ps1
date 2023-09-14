
# Path to csv with list of server names
$Servers = import-csv "C:\SCRIPTS\CSV_s\next_csv\new 9.csv"



$Servers | ForEach-Object { 

    # Variables
    $name = $_.Name
    
    # $file will be the name of the compiled list
    $file = "wmic_qfe_list.txt"
    
    # $path 
    $path = "\\" + $name + "\c$\installs\PCI_Audit_files\" + $file
    $outfile = "C:\temp\compiled_wmic_qfe_list2.txt"
    #$Target_path = $name2

    #$get = Get-Content $path 
    
        # Will show progress
        Write-Host Compiling info from $name 


                #Runs the command to compile into 1 doc
                 Get-ChildItem -Path $path -Filter "*.txt" | Get-Content | Add-Content -Path $outfile



}


