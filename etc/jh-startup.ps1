
$ErrorActionPreference = "Stop"

Write-Output "* Getting hyperv adapter..."
# Get-WMIObject Win32_networkadapter | Select-Object Name, AdapterType, InterfaceIndex | Sort Name | Format-Table

$idx=(Get-WMIObject Win32_networkadapter `
    | Select-Object Name, AdapterType, InterfaceIndex `
    | Where-Object -Property Name -eq 'Hyper-V Virtual Ethernet Adapter' `
)[0].InterfaceIndex
Write-Output "[I] IDX: $idx"
Write-Output "* Getting hyperv adapter done"

Write-Output "* Adapting the dev config..."
$ssh_initial = Get-Content -path ~\.ssh\config -Raw
$ssh_new = $ssh_initial -replace "HostName fe80::ff:fe00:1%%.*", "HostName fe80::ff:fe00:1%%$idx"
$ssh_new | Set-Content -NoNewline -Path ~\.ssh\config
ssh -o StrictHostKeyChecking=accept-new root@dev echo "ok"
Write-Output "* Adapting the dev config done"

Write-Output "* Launching Teams..."
# https://superuser.com/a/1626176/287025
# https://answers.microsoft.com/en-us/msteams/forum/all/teams-and-media-keys/136320bb-7af0-4bdc-8743-56608ff576b2?page=2
& "C:\Users\jho\AppData\Local\Microsoft\Teams\Update.exe" --processStart "Teams.exe" --process-start-args ( "--profile=AAD", "-disable-features=HardwareMediaKeyHandling" )
Write-Output "* Launching Teams done"

Write-Output "* Waiting for P drive..."
while (!(Test-Path "P:\")) { 
    Start-Sleep 5
}
Write-Output "* Waiting for P drive done"

Write-Output "* Launching PCloud..."
& "C:\Program Files\pCloud Drive\pCloud.exe"
Write-Output "* Launching PCloud done"

pause
