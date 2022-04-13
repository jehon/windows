
# https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/get-started/create-a-virtual-machine-in-hyper-v

$NetworkAdapterName = "vEthernet (J Internal 192.168.100.1)"

Write-Output "* Network adaptator"

Write-Output "** Listing network adaptator"
Get-NetAdapter | Select-Object -Property Name

Write-Output "** Testing if required is present"
if ( (Get-NetAdapter $NetworkAdapterName) ) {
    Write-Output "[I] The network adapter already exists"
} else {
    Write-Output "[I] Creating the network adapter"
    New-VMSwitch -Name privateSwitch -SwitchType Private -Name $NetworkAdapterName -NetAdapterName $NetworkAdapterName
}

Write-Output "* Creating the disk"

Write-Output "* Creating the VM"

Write-Output "* Setup the VM"
