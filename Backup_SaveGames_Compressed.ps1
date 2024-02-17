# Backup Save games to Onedrive and restore them.
# Hard coded created by Ulrik

$WorkingDirectory = pwd
$FoldersToBackup = New-Object System.Collections.ArrayList

#Import custom code
Import-Module -Name "$WorkingDirectory\Restore.psm1"
Import-Module -Name "$WorkingDirectory\Settings.psm1"

# Take backup of the files provided in variable
function Backup {
    $FolderName = ""
    try {
        Write-Host "`n Totalt: $($FoldersToBackup.Count) `n Folders: $FoldersToBackup" -BackgroundColor DarkCyan

        # Loop thru and take backup of each folder to Onedrive
        foreach ($item in $FoldersToBackup) {

            # Compress folders
            $FolderName = $item
            $Split_Item = $item.Split("\")
            Compress-Archive -Path $item -DestinationPath "G:\Min disk\Backup\$($Split_Item[$Split_Item.Count -1]).Zip"
            Write-Host "`n Compressing: $($Split_Item[$Split_Item.Count -1]) to Drive"
            $FoldersToBackup.Remove($FolderName) # Make sure to remove the folder once done so it wont retry same folder agen
        }

        Write-Host $Out_OK
        Write-Host "Backup Done processed $($FoldersToBackup.Count)" -BackgroundColor DarkRed
        st

    } catch {
        $FoldersToBackup.Remove($FolderName)
        Write-Host "`n Failed copying folder: $FolderName Does it Exist?" -BackgroundColor DarkRed
        Backup
    }
}


# Main Function that handles all the logic
function st {
    Write-Host "`n Automatic backup by Ulrik modified for Google Drive" -BackgroundColor DarkCyan
    $Backup = Read-Host "`n Write B Or R (Backup/Restore)"

    if ($Backup -eq "B") {
        Backup
    } elseif ($Backup -eq "R") {
        Write-Host "`n Restoring files from Backup"
        GetRestoreRP
        st
    } else {
        Write-Host "`n No such command"
        st
    }
}

function getbackup {
    $ContentD = Get-Content $BackupList
    $ContentD2 = $ContentD.Split("`n")

    foreach ($element in $ContentD2) {
        Write-Host "`n Items to backup: $Ufolders$element"
        $FoldersToBackup.Add("$Ufolders$element")
    }
}

getbackup # Read backup file
st # Start main program