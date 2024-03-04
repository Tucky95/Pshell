
$new_list = Get-Content "C:\CSV\test_vm_list.txt"


foreach ($vm in $new_list) {


    $dev = if ( $vm.startswith('END-ED')) #{ echo "$vm will be added to ENDERBY dev DRS rule" }
    $prod = if ( $vm.startswith('END-EP'))


#Gedding Affinity Rules

    #if ( $vm.endswith("0") -And $vm -like 'END-ED*' ) { echo "$vm will be added to GEDDING dev DRS rule" }

   if ( $vm -like 'END-ED' -And $vm.endswith("0") ) { echo "$vm will be added to GEDDING dev DRS rule" }
        
  #  if ( $vm.endswith("2") -and $vm.startswith('END-ED')) { echo "$vm will be added to GEDDING dev DRS rule" }

   # if ( $vm.endswith("4") -and $vm.startswith("END-ED*")) { echo "$vm will be added to GEDDING dev DRS rule" }

    #if ( $vm.endswith("6") -and $vm.startswith("END-ED*")) { echo "$vm will be added to GEDDING dev DRS rule" }

    #if ( $vm.endswith("8") -and $vm.startswith("END-ED*")) { echo "$vm will be added to GEDDING dev DRS rule" }

#Enderby Affinity Rules

    #if ( $vm.endswith("1") -and $vm.startswith("END-ED*")) { echo "$vm will be added to ENDERBY dev DRS rule" }

    if ( $vm.startswith('END-ED')) { echo "$vm will be added to ENDERBY dev DRS rule" }

   # if ( $vm.startswith('END-ED') -and $vm.endswith("3")) { echo "$vm will be added to ENDERBY dev DRS rule" }

    #if ( $vm.endswith("3") -and $vm.startswith("END-ED*")) { echo "$vm will be added to ENDERBY dev DRS rule" }

    #if ( $vm.endswith("5") -and $vm.startswith("END-ED*")) { echo "$vm will be added to ENDERBY dev DRS rule" }

    #if ( $vm.endswith("7") -and $vm.startswith("END-ED*")) { echo "$vm will be added to ENDERBY dev DRS rule" }

    #if ( $vm.endswith("9") -and $vm.startswith("END-ED*")) { echo "$vm will be added to ENDERBY dev DRS rule" }


}

