---
layout: post
title: Redirect port 22 of WSL
categories: [linux, wsl]
description:
keywords: linux, wsl
---

I use Jetbrain Gateway to ssh login into WSL2 (Windows Subsystem for Linux v2, Ubuntu 20.04 LTS)

However, the IP address of WSL2 changes every time when system reboots,
so I often have to add new connection with new IP address, which is annoying.

Find a solution on https://superuser.com/questions/1582234/make-ip-address-of-wsl2-static
which redirect local port 22 to WSL's port 22
Now I just needs to run the script before I wan to ssh,
and then ssh into localhost

Store the following contents as `wsl2_redirect_port_22.ps1`

```powershell
ubuntu2004.exe -c "sudo /etc/init.d/ssh start"
$wsl_ip = (ubuntu2004.exe -c "ifconfig eth0 | grep 'inet '").trim().split()| where {$_}
$regex = [regex] "\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b"

$ip_array = $regex.Matches($wsl_ip) | %{ $_.value }

$wsl_ip = $ip_array[0]

Write-Host "WSL Machine IP: ""$wsl_ip"""

netsh interface portproxy add v4tov4 listenport=22 listenaddress=0.0.0.0 connectport=22 connectaddress=$wsl_ip
```

Store the following contents as `wsl2_rediret_port_22.bat` (In the same directory of `wsl2_rediret_port_22.ps1`)

```bat
cd /D %~dp0
powershell.exe -ExecutionPolicy Bypass -File .\wsl2_redirect_port_22.ps1
pause
```

Run `wsl2_rediret_port_22.bat` as Administrator to redirect the port
