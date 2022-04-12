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

choco feature enable -n=allowGlobalConfirmation

choco install git
choco install vcbuildtools
choco install naps2
choco install mobaxterm
choco install hashtab
choco install psutils
choco install xmind
choco install vagrant
# https://github.com/gerardog/gsudo
choco install gsudo

# Non testé
choco install clickshare-desktop
choco install plantronicshub
choco install logitech-options
choco install unifying
choco install supertuxkart
choco install digikam
choco install greenshot
choco install firefox

# choco install freemind
# choco install jdk11 -params "static=false"
# choco install meld
# choco install gradle
# choco install nano
