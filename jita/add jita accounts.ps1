
#cd to bulk jita directory then import module
Import-Module .\bulk_jita_next.ps1

#2 methods
# - do in bulk from txt file

    cat .\servers_names.txt | persist "NEXT-PLC\SVC-Orchestrator-DB" -force



    # do manually on each server
        persist "NEXT-PLC\SVC-Orchestrator-DB" -computer_name "end-epws6110" -force