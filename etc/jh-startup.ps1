
$ErrorActionPreference = "Stop"

# Get-WMIObject Win32_networkadapter | Select-Object Name, AdapterType, InterfaceIndex | Sort Name | Format-Table

Write-Output "* Adapting the dev config..."
$idx=(Get-WMIObject Win32_networkadapter `
    | Select-Object Name, AdapterType, InterfaceIndex `
    | Where-Object -Property Name -eq 'Hyper-V Virtual Ethernet Adapter' `
)[0].InterfaceIndex

Write-Output "[I] IDX: $idx"

$ssh_initial = Get-Content -path ~\.ssh\config -Raw
$ssh_new = $ssh_initial -replace "HostName fe80::ff:fe00:1%%.*", "HostName fe80::ff:fe00:1%%$idx"
$ssh_new | Set-Content -NoNewline -Path ~\.ssh\config

# Initialize the ssh key (docker would otherwise cause problems)
ssh -o StrictHostKeyChecking=accept-new root@dev echo "ok"
Write-Output "* Adapting the dev config done"

Write-Output "* Launching PCloud..."
while (!(Test-Path "P:\")) { 
    Start-Sleep 5
}
& "C:\Program Files\pCloud Drive\pCloud.exe"
Write-Output "* Launching PCloud done"

pause
