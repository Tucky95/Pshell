$drvinffiles = Get-ChildItem -Path "C:\export-drivers\" -Filter "*.inf" -Recurse -File
foreach($drvinffile in $drvinffiles){
$drvinffile.FullName
pnputil.exe -i -a "$drvinffile.FullName"
}