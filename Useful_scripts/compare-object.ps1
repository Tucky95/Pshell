$dynatrace = Import-Csv "C:\SCRIPTS\!NEXT_SCRIPTS\DynaTrace_Install_status\DT short name export.csv"

$gsheet = Import-Csv "C:\SCRIPTS\!NEXT_SCRIPTS\DynaTrace_Install_status\Ice dynatrace deployment names.csv"



Compare-Object -ReferenceObject ( $gsheet ) -DifferenceObject ( $dynatrace ) | Out-GridView