
#
# We need to be admin to run this script
# 
if (Enter-Admin) {
    Write-Output "This script is restated as admin"
    Exit 0
}
# Write-Output $PSScriptRoot $RootDir
# . $RootDir\lib\require-admin.ps1

$RootDir = $PSScriptRoot

#
# Do we have choco installed?
#
Write-Output "Checking choco is installed..."
$testchoco = powershell choco -v
if (-not($testchoco)) {
  Write-Output "Installing choco"
  Set-ExecutionPolicy Bypass -Scope Process -Force
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
  iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}
choco feature enable -n=allowGlobalConfirmation
Write-Output "Checking choco is installed done"

#
# Loading some reg files
#
Write-Output "Loading some reg files..."
Get-ChildItem "$RootDir\etc" -Filter *.reg | Foreach-Object {
    $F = "$RootDir\etc\$_"
    Write-Output "Loading $F"
    regedit /S "$F"
}
Write-Output "Loading some reg files done"

#
# explorer.exe shell:startup
#
Write-Output "Installing startup scripts..."
Copy-Item -Recurse -Force -Path "$RootDir\startup\*" -Destination "C:\Users\jho\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
Write-Output "Installing startup scripts done"

Write-Output "Installing choco packages..."
choco install hashtab
choco install jdk11 -params "static=false"
choco install mobaxterm
choco install naps2
choco install psutils
choco install tortoisegit
choco install vagrant
choco install vcbuildtools
choco install xmind

# Non tested
choco install clickshare-desktop
choco install digikam
choco install firefox
choco install greenshot
choco install logitech-options
choco install plantronicshub
choco install unifying
choco install supertuxkart

# choco install freemind

Write-Output "Installing choco packages done"

#
# Configure some stuff
#

# For Vagrant
# [Environment]::SetEnvironmentVariable("VAGRANT_DEFAULT_PROVIDER", "hyperv", "User")

  hashtab `
  logitech-options `
  mobaxterm `
  naps2 `
  notepadplusplus `
  plantronicshub `
  psutils `
  virtualbox `
  vlc `
  vscode `
  wsl-ubuntu-2004 `
  wsl2

wsl --set-default-version 2
wslconfig /setdefault Ubuntu
