$WorkingDirectory = pwd
$BackupList = "$WorkingDirectory\Bfolders.txt"
$GDrive = "G:\Min disk\Backup\"

$Username = [System.Environment]::UserName
$Ufolders = "C:\Users\$Username"

Write-Host "`n Loaded Settings.psm1"

Export-ModuleMember -Variable * -Alias *