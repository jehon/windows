
# Thanks to https://superuser.com/a/1612289/287025

. $PSScriptRoot\..\lib\require-admin.ps1

if (Enter-Admin) {
    Write-Output "This script is restated as admin"
    Exit 0
}

$file = "C:\Users\jho\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\ext4.vhdx"
$distrib = "Ubuntu"

Write-Output "Stoping $distrib"
wsl -t $distrib

Write-Output "Shrinking drive"
Write-Output $file

Optimize-VHD -Path $file -Mode Full
# Get-ChildItem -Path $file | Select-Object FullName, @{Name = "Size"; E = { $_.Length / 1GB } }
Write-Output ((Get-Item $file).length/1GB) " GB"

Write-Output "All done"

pause
