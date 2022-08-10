
# https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/get-started/create-a-virtual-machine-in-hyper-v
# https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/try-hyper-v-powershell

$ErrorActionPreference = "Stop"

# Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart

$VMName = "dev"
$VMRoot = "C:\users\jho\src\vm"
$VMDisk = "$VMRoot\disk.vhdx"
$NetworkSwitchName = "J - 192.168.100.1"

$ISOFile = "$VMRoot\debian.iso"
$ISOURL = "https://cdimage.debian.org/cdimage/weekly-builds/amd64/iso-cd/debian-testing-amd64-netinst.iso"

New-Item -ItemType Directory -ErrorAction SilentlyContinue $VMRoot

Write-Output "* Network adaptator"
# Get-VMSwitch  * | Format-Table Name
if ( (Get-VMSwitch $NetworkSwitchName) 2> $null) {
    Write-Output "[I] The network adapter already exists"
} else {
    Write-Output "[I] Creating the network adapter"
    New-VMSwitch -Name $NetworkSwitchName -SwitchType Internal
    Set-NetIPAddress -InterfaceAlias "vEthernet ($($NetworkSwitchName))" -IPAddress 192.168.100.1 -PrefixLength 30
}

Write-Output "* Creating the disk"

if (Test-Path $VMDisk) {
    Write-Output "[I] Remove previous file"
    Remove-Item $VMDisk
}
New-VHD -Path $VMDisk -SizeBytes 60GB -Fixed

Write-Output "* Creating the VM"
# https://docs.microsoft.com/en-us/powershell/module/hyper-v/new-vm?view=windowsserver2022-ps
New-VM -Name $VMName `
    -Path $VMRoot `
    -VHDPath $VMDisk `
    -Switch "Default Switch"

# https://docs.microsoft.com/en-us/powershell/module/hyper-v/set-vm
Set-VM -Name $VMName `
    -AutomaticCheckpointsEnabled $false

# https://docs.microsoft.com/en-us/powershell/module/hyper-v/set-vmprocessor?view=windowsserver2022-ps
Set-VMProcessor  -VMName $VMName `
    -Count 2 `
    -Maximum 100 `
    -Reserve 25 `
    -ExposeVirtualizationExtensions $true

# https://docs.microsoft.com/en-us/powershell/module/hyper-v/set-vmmemory?view=windowsserver2022-ps
Set-VMMemory -VMName $VMName `
    -StartupBytes 4096 `
    -DynamicMemoryEnabled 1 `
    -MaximumBytes 8192 `
    -MinimumBytes 2048

# Add a eth1 additionnal interface
Add-VMNetworkAdapter -VMName $VMName `
    -SwitchName $NetworkSwitchName

Write-Output "* Add the iso"
if (Test-Path $ISOFile) {
    Write-Output "[I] Using already downloaded iso at $ISOFile"
} else {
    Write-Output "[I] Downloading iso file $ISOURL to $ISOFile"
    Invoke-WebRequest -Uri $ISOURL -OutFile $ISOFile
}

# TODO: modify the iso for automatic install

Set-VMDvdDrive -VMName $VMName `
    -ControllerNumber 1 `
    -Path $ISOFile

Write-Output "* Setup $VMName"
Start-VM -Name $VMName

# TODO: quick config of debian
# TODO: run start.sh
# TODO: update ssh key !!!
