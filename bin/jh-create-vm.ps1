
# https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/get-started/create-a-virtual-machine-in-hyper-v
# https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/try-hyper-v-powershell

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
}

Write-Output "* Creating the disk"

if (Test-Path $VMDisk) {
    Write-Output "[I] Remove previous file"
    Remove-Item $VMDisk
}
New-VHD -Path $VMDisk -SizeBytes 60GB -Fixed

Write-Output "* Creating the VM"
New-VM -Name $VMName `
    -Path $VMRoot\dev `
    -MemoryStartupBytes 4096Mb `
    -VHDPath $VMDisk `
    -Switch $NetworkSwitchName `

Set-VMMemory -VMName $VMName `
    -DynamicMemoryEnabled 0
#    -MaximumBytes <Int64>
#    -MinimumBytes <Int64>

Add-VMNetworkAdapter -VMName $VMName `
    -SwitchName "Default Switch"


Write-Output "* Add the iso"
if (Test-Path $ISOFile) {
    Write-Output "[I] Using already downloaded iso at $ISOFile"
} else {
    Write-Output "[I] Downloading iso file $ISOURL to $ISOFile"
    Invoke-WebRequest -Uri $ISOURL -OutFile $ISOFile
}

