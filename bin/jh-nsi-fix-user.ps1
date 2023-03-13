
# must be at C:\ to work !  how bizarre

. $PSScriptRoot\lib\require-admin.ps1

if (Enter-Admin) {
    Write-Output "This script is restated as admin"
    Exit 0
}

Write-Output "GP Update..."
# https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/gpupdate
gpupdate /force /Wait:-1

Write-Output "...done"

pause
