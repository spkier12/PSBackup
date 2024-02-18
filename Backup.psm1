$FoldersToBackup = New-Object System.Collections.ArrayList
$NewFolderCreation = "unknownBackup"

# Take backup of the files provided in variable
function Backup {
    $FolderName = ""
    try {
        Write-Host "`n Totalt: $($FoldersToBackup.Count) `n Folders: $FoldersToBackup" -BackgroundColor DarkCyan

        # For each url in variable split them and get name and true path
        foreach ($item in $FoldersToBackup) {

            # Compress folders
            $FolderName = $item
            $Split_Item = $item.Split("\")
            Compress-Archive -Path $item -DestinationPath "$GDrive$NewFolderCreation\$($Split_Item[$Split_Item.Count -1]).Zip"
            Write-Host "`n Compressing: $($Split_Item[$Split_Item.Count -1]) to Drive"

            # Make sure to remove the folder once done so it wont retry same folder agen
            $FoldersToBackup.Remove($FolderName)
        }

        # Let user know and return to start menu
        Write-Host $Out_OK
        Write-Host "Backup Done processed $($FoldersToBackup.Count)" -BackgroundColor DarkRed
        st

    } catch {
        $FoldersToBackup.Remove($FolderName)
        Write-Host "`n Failed copying folder: $FolderName Does it Exist?" -BackgroundColor DarkRed
        Backup
    }
}

function getbackup {
    $ContentD = Get-Content $BackupList
    $ContentD2 = $ContentD.Split("`n")

    foreach ($element in $ContentD2) {
        Write-Host "`n Items to backup: $Ufolders$element"
        $FoldersToBackup.Add("$Ufolders$element")
    }

    # Create a new folder using SystemDate
    $CurrentDate = Get-Date
    $CurrentDate2 = $CurrentDate.ToString()
    $CurrentDate3 = $CurrentDate2.Replace("/", "-").Replace(":", "-")
    $NewFolderCreation = $CurrentDate3

    # Create folder in drive
    mkdir $GDrive$NewFolderCreation
    Backup
}