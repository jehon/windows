#
# Create link in: shell:startup
#

$ErrorActionPreference = "Stop"

# Write-Output "* Getting hyperv adapter..."
# # Get-WMIObject Win32_networkadapter | Select-Object Name, AdapterType, InterfaceIndex | Sort Name | Format-Table

# $idx=(Get-WMIObject Win32_networkadapter `
#     | Select-Object Name, AdapterType, InterfaceIndex `
#     | Where-Object -Property Name -eq 'Hyper-V Virtual Ethernet Adapter' `
# )[0].InterfaceIndex
# Write-Output "[I] IDX: $idx"
# Write-Output "* Getting hyperv adapter done"

# Write-Output "* Adapting the dev config..."
# $ssh_initial = Get-Content -path ~\.ssh\config -Raw
# $ssh_new = $ssh_initial -replace "HostName fe80::ff:fe00:1%%.*", "HostName fe80::ff:fe00:1%%$idx"
# $ssh_new | Set-Content -NoNewline -Path ~\.ssh\config
# ssh -o StrictHostKeyChecking=accept-new root@dev echo "ok"
# Write-Output "* Adapting the dev config done"

if (Test-Path "D:\") {
	Write-Output "PCloud is already present at D:"
} else {
	Write-Output "* Waiting for P drive..."
	while (!(Test-Path "P:\")) { 
		Start-Sleep 5
		Write-Output "."
	}
	Write-Output "* Waiting for P drive done"

	Write-Output "* Launching PCloud..."
	& "C:\Program Files\pCloud Drive\pCloud.exe"
	Write-Output "* Launching PCloud done"
}

Do {
    Get-Date
    Write-Output "* Launching wsl..."
    & debian run "/home/jehon/src/devstack/wsl.sh"
    Write-Output "* Launching wsl terminated"
	Write-Output "* Relaunching in 10 seconds"
    Start-Sleep -Seconds 10
} While ($true)
