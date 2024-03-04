
$list = Get-Content C:\CSV\edas_vms_list.txt

    foreach ($vm in $list) {
   

        if ( $vm.endswith("0") ) { echo "$vm is a gedding vm" }

        if ( $vm.endswith("2") ) { echo "$vm is a gedding vm" }

        if ( $vm.endswith("4") ) { echo "$vm is a gedding vm" }
    
        if ( $vm.endswith("6") ) { echo "$vm is a gedding vm" }

        if ( $vm.endswith("8") ) { echo "$vm is a gedding vm" }

        if ( $vm.endswith("1") ) { echo "$vm is a enderby vm" }

        if ( $vm.endswith("3") ) { echo "$vm is a enderby vm" }

        if ( $vm.endswith("5") ) { echo "$vm is a enderby vm" }

        if ( $vm.endswith("7") ) { echo "$vm is a enderby vm" }

        if ( $vm.endswith("9") ) { echo "$vm is a enderby vm" }


}