
# must be at C:\ to work !  how bizarre

. $PSScriptRoot\..\lib\require-admin.ps1

if (Enter-Admin) {
    Write-Output "This script is restarted as admin"
    Exit 0
}

# As Admin

Write-Output "Updating..."
choco upgrade all

Write-Output "...done"
pause
