
#
# We need to be admin to run this script
# 
if (Enter-Admin) {
    Write-Output "This script is restated as admin"
    Exit 0
}

$ErrorActionPreference = "Stop"

# . $PSScriptRoot\lib\require-admin.ps1

Write-Output "Enable hyperv..."
# See https://developer.hashicorp.com/vagrant/docs/providers/hyperv
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
Write-Output "Enable hyperv done"

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
Write-Output "Loading jho.reg..."
Write-Output "Loading $F"
regedit /S "$PSScriptRoot\etc\jh.reg"
Write-Output "Loading jho.reg done"

#
# explorer.exe shell:startup
#

Write-Output "Installing choco packages..."
choco install digikam
choco install eclipse
# choco install encfs4win
choco install hashtab
choco install git
# choco install jdk11 -params "static=false"
choco install mobaxterm
choco install naps2
choco install nodejs
choco install notepadplusplus
# choco install psutils
# choco install vagrant
# choco install vcbuildtools
choco install vlc
choco install vscode
choco install xmind

# Non tested
# choco install clickshare-desktop
# choco install firefox
# choco install greenshot
# choco install logitech-options
# choco install plantronicshub
# choco install unifying
# choco install supertuxkart

Write-Output "Installing choco packages done"

#
# Configure some stuff
#

# wsl --set-default-version 2
# wslconfig /setdefault Ubuntu

setx VAGRANT_DEFAULT_PROVIDER hyperv
setx DOCKER_HOST "ssh://root@dev"
