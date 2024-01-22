

### Add full path to csv file with servers listed
$server_list = Import-Csv "C:\SCRIPTS\CSV_s\next_csv\new 9.csv"



    Foreach ($Server in $server_list) {

    #Set variables for Destination files
    $Name = $Server.Name  
    $Destination = "\\" + $Name + "\c$\Installs"
    $Folder_name = "PCI_Audit_files"



          ### Shows progress of csv
                Write-Host Creating $Folder_name in $Destination -ForegroundColor Green
                

                                ### Creates new folder using above variables

                                    New-Item -Path $Destination -Name $Folder_name -ItemType directory -Force 
                                    

   }
