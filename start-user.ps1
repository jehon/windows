
$ErrorActionPreference = "Stop"

Write-Output "Configuring git..."
git config --global user.name "Jean Honlet"
git config --global user.email jehon@users.noreply.github.com

git config --global push.default current
# Push tags
git config --global push.followtags true
git config --global pull.rebase true
git config --global rebase.autoStash true
git config --global fetch.prune true
git config --global fetch.writeCommitGraph true
git config --global init.defaultBranch main
Write-Output "Configuring git done"

Write-Output "* Installing startup scripts..."
# https://learn.microsoft.com/en-us/dotnet/api/system.environment.specialfolder
$userStartupFolder = [Environment]::GetFolderPath("Startup")
Write-Output "[I] Startup folder: $userStartupFolder"
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$userStartupFolder\jh-startup.lnk")
$Shortcut.TargetPath = "$PSScriptRoot\bin\jh-startup.ps1"
$Shortcut.Save()
Write-Output "* Installing startup scripts done"

Write-Output "* Installing config..."
Copy-Item -Recurse -Force -Path "$PSScriptRoot\etc\ssh_config" -Destination  "$home/.ssh/config"
Write-Output "* Installing config done"

& $PSScriptRoot\etc\jh-startup.ps1

Write-Output "start-user: ok"
