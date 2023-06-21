# windows

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/jehon/windows/main/start.ps1'))

net use \\fd54--0100-0002.ipv6-literal.net /u:WORKGROUP\jehon
net use \\fe80--211-32ff-fe1b-8f92.ipv6-literal.net /u:WORKGROUP\jehon

# System

## Configure

In explorer => right click in "folders" (left pane) => show all folders

## SSH (OpenSSH)

Forward SSH keys to VSCode:
- https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement

## Installed

- Hyper-V (features)

check C:\ProgramData\Microsoft\Windows\Virtual Hard Disks

## Startup applications

Gestionnaire:
-> clic droit sur le bouton Démarrer
-> Gestionnaire des tâches
-> Démarrage

Shell:
-> Win-R -> shell:startup

# Office

Timelines: https://www.officetimeline.com/fr/telecharger

## Outlook

Activate VBA:
https://www.extendoffice.com/documents/outlook/1298-outlook-add-developer-tab.html
Options > customize ribbon > [v] Developper
