
$ErrorActionPreference = "Stop"

clear
vagrant destroy -f
vagrant up | tee -filepath jh-vagrant.log
