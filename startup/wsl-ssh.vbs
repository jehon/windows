
set ws=wscript.createobject("wscript.shell")
ws.run "C:\Windows\System32\wsl.exe -u root -d ubuntu -- service ssh start",0
