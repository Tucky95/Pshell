
$servername = "end-epfs02-cl02"

gwmi Win32_PerfFormattedData_PerfProc_Process -filter "Name <> '_Total' and Name <> 'Idle'" -Computer $servername | where { $_.PercentProcessorTime -gt 0 } #| select Name, PercentProcessorTime
