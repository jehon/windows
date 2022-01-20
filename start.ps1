
# Get-Help Invoke-Expression

$testchoco = powershell choco -v
if (-not($testchoco)) {
  Write-Output "Installing choco"
  Set-ExecutionPolicy Bypass -Scope Process -Force
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
  iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

choco feature enable -n=allowGlobalConfirmation

choco install `
  docker-desktop `
  firefox `
  git `
  google-drive-file-stream `
  greenshot `
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

# Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu.appx -UseBasicParsing

# gradle jdk11 maven
# vcbuildtools

# choco install freemind
# choco install nano
# choco install xmind
