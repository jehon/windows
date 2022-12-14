
$ErrorActionPreference = "Stop"

clear
Remove-Item -Force -Path jh-vagrant.log
vagrant destroy -f
vagrant up | tee -filepath jh-vagrant.log
