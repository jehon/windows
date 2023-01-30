
$ErrorActionPreference = "Stop"

$LogFile = "jh-vagrant.log"

clear
if (Test-Path $LogFile) {
    Remove-Item -Force -Path $LogFile
}

git pull --rebase --autostash
vagrant destroy -f
vagrant up | tee -filepath $LogFile
