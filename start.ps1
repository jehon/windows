
#
# We need to be admin to run this script, but we can not use lib, 
# since it may be unavailable.
# 
$ErrorActionPreference = "Stop"

# . $PSScriptRoot\lib\require-admin.ps1

Write-Output "Enable hyperv..."
# See https://developer.hashicorp.com/vagrant/docs/providers/hyperv
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
Write-Output "Enable hyperv done"

#
# Loading some reg files
#

# Write-Output "Loading jho.reg..."
# Write-Output "Loading $F"
# regedit /S "$PSScriptRoot\etc\jh.reg"
# Write-Output "Loading jho.reg done"

#
# explorer.exe shell:startup
#

Write-Output "Installing choco packages..."
choco install hashtab
choco install git
# choco install naps2
choco install nerd-fonts-delugiamono-complete
# choco install notepadplusplus
# choco install vlc
# choco install vscode

# Non tested
# choco install clickshare-desktop
# choco install firefox
# choco install greenshot
# choco install logitech-options
# choco install plantronicshub
# choco install supertuxkart

Write-Output "Installing choco packages done"

#
# Configure some stuff
#

# setx DOCKER_HOST "ssh://root@localhost"
