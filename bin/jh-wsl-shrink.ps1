
# Thanks to https://superuser.com/a/1612289/287025

. $PSScriptRoot\lib\require-admin.ps1

if (Enter-Admin) {
    Write-Output "This script is restated as admin"
    Exit 0
}

$distrib = "Debian"

# https://learn.microsoft.com/en-us/windows/wsl/disk-space#how-to-locate-the-vhdx-file-and-disk-path-for-your-linux-distribution
$file = (Get-ChildItem -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss | Where-Object { $_.GetValue("DistributionName") -eq $distrib }).GetValue("BasePath") + "\ext4.vhdx"

Write-Output "* Distribution:  $distrib"
Write-Output "* Detected file: $file"

Write-Output "* Stopping..."
# shutdown terminate imediately (see wsl --help)
wsl --shutdown $distrib
Write-Output "* Stopping done"

Write-Output "* Shrinking drive..."
Optimize-VHD -Path $file -Mode Full
# Get-ChildItem -Path $file | Select-Object FullName, @{Name = "Size"; E = { $_.Length / 1GB } }
Write-Output ((Get-Item $file).length/1GB) " GB"
Write-Output "* Shrinking drive done"

Write-Output "* All done"

pause
