
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco feature enable -n=allowGlobalConfirmation

choco install docker-desktop firefox git google-drive-file-stream greenshot hashtab mobaxterm naps2 notepadplusplus plantronicshub psutils vscode wsl2

# gradle jdk11 maven
# vcbuildtools

# choco install freemind
# choco install nano
# choco install xmind
