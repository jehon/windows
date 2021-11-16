# $RootDir = Split-Path -parent $PSScriptRoot
$RootDir = $PSScriptRoot

# Write-Output $PSScriptRoot $RootDir
# . $RootDir\lib\require-admin.ps1

if (Enter-Admin) {
    Write-Output "This script is restated as admin"
    Exit 0
}

Get-ChildItem "$RootDir\etc" -Filter *.reg | Foreach-Object {
    $F = "$RootDir\etc\$_"
    Write-Output "Loading $F"
    regedit /S "$F"
}

# explorer.exe shell:startup
Write-Output "Installing startup scripts"
Copy-Item -Recurse -Force -Path "$RootDir\startup\*" -Destination "C:\Users\jho\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
