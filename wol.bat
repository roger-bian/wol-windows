@echo off
set "MACLIST=.\mac_list.txt"
set "SCRIPT=.\wol.ps1"
set "BROADCAST=255.255.255.255"
set "PORT=9"

powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT%" -MacListPath "%MACLIST%" -BroadcastAddress "%BROADCAST%" -Port %PORT%
