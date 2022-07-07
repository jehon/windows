
# https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/get-started/create-a-virtual-machine-in-hyper-v
# https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/try-hyper-v-powershell

# Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart

$VMName = "dev"
$VMRoot = "C:\users\jho\src\vm"
$NetworkSwitchName = "J - 192.168.100.1"

Write-Output "* Network adaptator"
# Get-VMSwitch  * | Format-Table Name

if ( (Get-VMSwitch $NetworkSwitchName) 2> $null) {
    Write-Output "[I] The network adapter already exists"
} else {
    Write-Output "[I] Creating the network adapter"
    New-VMSwitch -Name $NetworkSwitchName -SwitchType Internal
}

Write-Output "* Creating the disk"
New-VHD -Path $VMRoot\disk.vhdx -SizeBytes 60GB -Fixed

Write-Output "* Creating the VM"
New-VM -Name $VMName `
    -Path $VMRoot\dev `
    -MemoryStartupBytes 4096Mb `
    -VHDPath $VMRoot\disk.vhdx `
    -Switch $NetworkSwitchName `

Set-VMMemory -VMName $VMName `
    -DynamicMemoryEnabled 0
#    -MaximumBytes <Int64>
#    -MinimumBytes <Int64>

Add-VMNetworkAdapter -VMName $VMName `
    -SwitchName "Default Switch"

