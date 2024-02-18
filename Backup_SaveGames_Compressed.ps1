# Backup Save games to GoogleDrive and restore them.
# created by Ulrik

$WorkingDirectory = pwd

#Import custom code
Import-Module -Name "$WorkingDirectory\Restore.psm1"
Import-Module -Name "$WorkingDirectory\Backup.psm1"
Import-Module -Name "$WorkingDirectory\Settings.psm1"

# Main Function that handles all the logic
function st {
    
    # Get date
    $GetDate = Get-Date
    
    Write-Host "`n Date: $GetDate Automatic backup by Ulrik modified for Google Drive" -BackgroundColor DarkCyan
    $Backup = Read-Host "`n Write B Or R (Backup/Restore)"

    if ($Backup -eq "B") {
        getbackup

    } elseif ($Backup -eq "R") {
        Write-Host "`n Restoring files from Backup"
        GetRestoreRP
        st

    } else {
        Write-Host "`n No such command"
        st
    }
}

st # Start main program