
# $RootDir = Split-Path -parent $PSScriptRoot
$RootDir = $PSScriptRoot

# Write-Output $PSScriptRoot $RootDir

. $RootDir\lib\require-admin.ps1

if (Enter-Admin) {
    Write-Output "This script is restated as admin"
    Exit 0
}

Get-ChildItem "$RootDir\etc" -Filter *.reg | Foreach-Object {
    $F = "$RootDir\etc\$_"
    Write-Output "Loading $F"
    regedit /S "$F"
}

choco feature enable -n=allowGlobalConfirmation

choco install git
choco install docker-desktop
choco install vcbuildtools
choco install naps2
choco install mobaxterm
choco install hashtab
choco install psutils

# choco install freemind
# choco install jdk11 -params "static=false"
# choco install meld
# choco install gradle
# choco install nano
choco install xmind
