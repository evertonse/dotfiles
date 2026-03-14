@echo off
start "" "C:\ahk\league.ahk"
start "" "C:\ahk\mouse.ahk"

taskkill /f /im 'C:\ahk\remaps.exe' >nul 2>&1
REM powershell -Command "Start-Process 'C:\ahk\remaps.exe' -Verb RunAs"
start "" /min "C:\ahk\remaps.exe"



powershell -Command "New-NetQosPolicy -Name 'LeagueGameQoS' -AppPathNameMatchCondition 'League of Legends.exe' -DSCPAction 46" >nul 2>&1
powershell -Command "New-NetQosPolicy -Name 'LeagueClientQoS' -AppPathNameMatchCondition 'LeagueClientUx.exe' -DSCPAction 46" >nul 2>&1

powershell -Command "Enable-MMAgent -ApplicationLaunchPrefetching" >nul 2>&1




REM Keyboard Stuff
powershell -ExecutionPolicy Bypass -File "C:\ahk\keyboard-rate.ps1"

REM Use the windows register to set priority to high for process called "League of Legends (TM) Client.exe"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\League of Legends.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f

REM Disable Sticky Keys
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /v Flags /t REG_SZ /d 0 /f

@echo off
echo Disabling Microsoft Defender (policy + realtime protection)...
echo.

REM ---- Main Defender policy ----
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" ^
 /v DisableAntiSpyware /t REG_DWORD /d 1 /f

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" ^
 /v DisableAntiVirus /t REG_DWORD /d 1 /f

REM ---- Real-time protection policies ----
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" ^
 /v DisableBehaviorMonitoring /t REG_DWORD /d 1 /f

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" ^
 /v DisableOnAccessProtection /t REG_DWORD /d 1 /f

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" ^
 /v DisableScanOnRealtimeEnable /t REG_DWORD /d 1 /f

REM ---- Disable Defender services startup (best-effort) ----
sc config WinDefend start= disabled >nul 2>&1
sc config WdNisSvc start= disabled >nul 2>&1

REM Make sure that the hypervisor launch is enabled in your boot configuration. You can validate this by running elevated powershell:
REM bcdedit /enum | findstr -i hypervisorlaunchtype
REM If you see hypervisorlaunchtype Off, then the hypervisor is disabled. To enable it run in an elevated powershell:
REM https://learn.microsoft.com/en-us/windows/wsl/troubleshooting#error-0x80370102-the-virtual-machine-could-not-be-started-because-a-required-feature-is-not-installed
bcdedit /set hypervisorlaunchtype Auto


REM ---- Disable Disk Indexing (Windows Search) ----
net stop "WSearch"


REM ---- Disable Telemetry ----
net stop "DiagTrack"
sc config "DiagTrack" start= disabled

REM ---- Disable Connected User Experiences Telemetry ----
net stop "Connected User Experiences and Telemetry"

REM ---- Stop Windows Update temporarily (safe) ----
net stop "wuauserv"

REM ---- Disable Print Spooler (if you don't use printers) ----
net stop "Spooler"

REM ---- Stop Retail Demo Service (OEM bloat) ----
net stop "RetailDemo"

REM ---- Stop Fax Service ----
net stop "Fax"

REM ============================================================
REM  AGGRESSIVE GAMING OPTIMIZATION (SAFE-ISH) STARTUP.BAT
REM  - Run as Administrator
REM  - WARNING: Aggressive. Read comments. Some lines are destructive.
REM ============================================================

REM -------------------------
REM  0) Basic safety notice
REM -------------------------

REM -------------------------
REM  Ultimate Performance Power Plan is active
REM  GUID used below is the built-in Ultimate Performance plan GUID.
REM -------------------------
REM powercfg -setactive E9A42B02-D5DF-448D-AA00-03F14749EB61
:: Optional: Disable power throttling (Win10+)
powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_PROCESSOR IDLEDISABLE 1
powercfg /SETACTIVE SCHEME_CURRENT


REM -------------------------
REM  4) Disable background apps (user-level toggles)
REM -------------------------
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppPrivacy" /v LetAppsRunInBackground /t REG_DWORD /d 2 /f

REM -------------------------
REM  5) Disable Game DVR and related recording (reduces hitching)
REM -------------------------
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehavior /t REG_DWORD /d 2 /f

REM -------------------------
REM  6) GPU: Hardware-accelerated GPU scheduling (HAGS)
REM      Note: supported only on compatible drivers/GPUs. No harm trying.
REM -------------------------
REM reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f

REM -------------------------
REM  7) Disable unneeded services (stop only here; not permanently disable)
REM     Note: stopping services at runtime reduces immediate resource use.
REM     To permanently disable, change 'sc config <name> start= disabled' (commented out below)
REM -------------------------
echo Stopping services (non-critical for gaming). Some may report errors if missing.
sc stop "WSearch"          >nul 2>&1     REM Windows Search (indexing)
sc stop "wuauserv"         >nul 2>&1     REM Windows Update service (stopping only)
sc stop "DoSvc"            >nul 2>&1     REM Delivery Optimization
sc stop "Spooler"          >nul 2>&1     REM Print Spooler
sc stop "bthserv"          >nul 2>&1     REM Bluetooth Support
sc stop "WbioSrvc"         >nul 2>&1     REM Biometrics
sc stop "CDPSvc"           >nul 2>&1     REM Connected Devices Platform Service
sc stop "CDPUserSvc_"      >nul 2>&1     REM per-user CDP instances (wildcards not supported via sc)
sc stop "TabletInputService" >nul 2>&1   REM Touch Keyboard and Handwriting Panel
sc stop "RetailDemo"       >nul 2>&1
sc stop "smartscreen"      >nul 2>&1
sc stop "XboxGipSvc"       >nul 2>&1
sc stop "XblAuthManager"   >nul 2>&1
sc stop "XblGameSave"      >nul 2>&1
sc stop "XboxNetApiSvc"    >nul 2>&1

REM -------------------------
REM  8) OPTIONAL: Permanently disable a service (DANGEROUS)
REM  Uncomment only if you know what you do.
REM  Example: to permanently disable Windows Search:
sc config "WSearch" start= disabled


REM ------------------------------------------ REM
REM -----------NetWork------------------------ REM
REM ------------------------------------------ REM

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{NIC-GUID}" /v TcpAckFrequency /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{NIC-GUID}" /v TCPNoDelay /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{GUID}" /v TcpAckFrequency /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{GUID}" /v TCPNoDelay /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{GUID}" /v TcpDelAckTicks /t REG_DWORD /d 0 /f

REM ------------DEFAULTS------------------------------

REM netsh interface tcp set heuristics enabled
REM netsh int udp set global uro=enabled
REM netsh interface tcp set global congestionprovider=none
REM netsh int tcp set global autotuninglevel=normal
REM netsh int tcp set global ecncapability=disabled
REM netsh int tcp set global timestamps=disabled
REM netsh int tcp set global rss=enabled
REM netsh int tcp set glbal rsc=enabled

REM Resetting such as below
REM netsh int ip reset
REM ipconfig /flushdns
REM route -f

REM ------------------------------------------

netsh interface tcp set heuristics disabled

netsh int udp set global uro=enabled
netsh int udp set global uso=enabled

REM netsh int tcp set global autotuninglevel=enabled
netsh int tcp set global autotuninglevel=normal

netsh int tcp set global ecncapability=disabled
netsh int tcp set global timestamps=disabled
netsh int tcp set global rss=enabled
netsh int tcp set global rsc=disabled




REM ------------------------------------------ REM
REM -----------NetWork------------------------ REM
REM ------------------------------------------ REM



REM -------------------------
REM Core parking: aggressive disable
REM https://learn.microsoft.com/en-us/answers/questions/1524213/remove-parked-status-of-cpu
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "Attribute" /t REG_DWORD /d 0 /f

REM -------------------------
REM 13) RAM compression: option to disable (risky)
REM     Disabling memory compression may reduce pagefile overhead but increases RAM usage.
REM     COMMENTED OUT by default. Uncomment only after research and full backups.
REM -------------------------
REM reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisableCompression /t REG_DWORD /d 1 /f

REM Enabling for now
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisableCompression /t REG_DWORD /d 0 /f

REM -------------------------
REM 14) Tweak visual effects (system animation off)
REM -------------------------
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f

REM -------------------------
REM 15) Telemetry reduction (policy) - reduces telemetry sending
REM     This is not guaranteed to completely disable Microsoft telemetry but reduces it.
REM -------------------------
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

REM -------------------------
REM 16) Disable background apps and tips notifications
REM -------------------------
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscriptionId /t REG_DWORD /d 0 /f

REM -------------------------
REM 17) Aggressive optional items (COMMENTED OUT — HIGH RISK)
REM     - Disable Windows Defender real-time protection (not recommended)
REM     - Disable Windows Update permanently (not recommended)
REM     - Disable Virtualization Based Security / HVCI (can break security)
REM     - Remove TDR (GPU reset) or set TdrDelay to huge value (unsafe)
REM  These are left commented. You can enable them intentionally by removing REM.
REM -------------------------
REM ***** DANGEROUS: Disable Defender real-time (DO NOT UNCOMMENT unless you KNOW risks)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f


REM ***** DANGEROUS: Disable Windows Update service permanently
sc config wuauserv start= disabled

REM ***** DANGEROUS: TDR delay increase (can hide GPU crashes)
REM reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDelay /t REG_DWORD /d 10 /f

REM -------------------------
REM 18) Final steps: flush DNS cache and inform user
REM -------------------------
REM ipconfig /flushdns >nul 2>&1
echo "Script finished you may close"
pause
