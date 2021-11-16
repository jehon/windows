
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco feature enable -n=allowGlobalConfirmation

choco install docker-desktop firefox git google-drive-file-stream hashtab mobaxterm naps2 psutils vscode vcbuildtools wsl2

# choco install jdk11 -params "static=false"
# choco install freemind
# choco install gradle
# choco install nano
# choco install xmind
