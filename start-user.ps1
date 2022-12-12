
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

Write-Output "Installing startup scripts..."
# https://learn.microsoft.com/en-us/dotnet/api/system.environment.specialfolder
$userStartupFolder = [Environment]::GetFolderPath("Startup")
Copy-Item -Recurse -Force -Path "$PSScriptRoot\etc\jh-startup.ps1" -Destination "$userStartupFolder\jh-startup.ps1"
# New-Item -Path "$userStartupFolder\jh-startup.ps1" -ItemType SymbolicLink -Value "$PSScriptRoot\etc\jh-startup.ps1"
Write-Output "Installing startup scripts done"

& $PSScriptRoot\etc\jh-startup.ps1

Write-Output "start-user: ok"
