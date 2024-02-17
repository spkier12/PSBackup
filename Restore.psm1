$WorkingDirectory = pwd
Import-Module -Name "$WorkingDirectory\Settings.psm1"

$GetBackupPath = New-Object System.Collections.ArrayList

# Restores data from the backup folders and place the .zip folders back into their original locations
function RestoreDataRP {
    $FolderCopying = ""
    try {
        foreach ($item in $GetBackupPath) {
            $GetBackupPath2 = $item.Split("\")
            $NameFolder2 = $GetBackupPath2[$GetBackupPath2.Count -1]
            $FolderCopying = $item

            # Remove the folder name to get the true path
            $PathOfRestore = $item.Replace("$NameFolder2", "")

            Write-Host "Copying Folder: $GDrive$NameFolder2 to $PathOfRestore$NameFolder2"

            # Extract the .zip file into the restore path
            Expand-Archive -Path "$GDrive$NameFolder2.zip" -Destination "$PathOfRestore" -Force

            # Remove the path from array so it wont re-try agen
            $GetBackupPath.Remove($item)

        }
    } catch {
        $GetBackupPath.Remove($FolderCopying)
        Write-Host "`n Error: $FolderCopying [Unkown File]" -BackgroundColor Red
        RestoreDataRP
    }
}

function GetRestoreRP {
    $GetContent = Get-Content $BackupList
    $SplitContent = $GetContent.Split("`n")

    foreach ($item in $SplitContent) {
        $GetBackupPath.Add("$Ufolders$item")
    }

    RestoreDataRP
}

Write-Host "`n Loaded Restore.psm1"
Export-ModuleMember -Function * -Alias *