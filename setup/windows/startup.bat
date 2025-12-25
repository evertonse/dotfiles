@echo off
start "" "C:\ahk\league.ahk"
start "" "C:\ahk\mouse.ahk"

echo === ENABLING GAMING MODE ===

REM ---- Disable Disk Indexing (Windows Search) ----
REM net stop "WSearch"

REM ---- Disable SysMain (Superfetch) - reduces stuttering on HDD/SSD ----
REM net stop "SysMain"

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
REM  2) Ensure Ultimate Performance Power Plan is active
REM     GUID used below is the built-in Ultimate Performance plan GUID.
REM -------------------------
powercfg -setactive E9A42B02-D5DF-448D-AA00-03F14749EB61
REM (If the plan doesn't exist on Windows Home, this will fail harmlessly.)

REM -------------------------
REM  4) Disable background apps (user-level toggles)
REM -------------------------
REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f
REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppPrivacy" /v LetAppsRunInBackground /t REG_DWORD /d 2 /f

REM -------------------------
REM  5) Disable Game DVR and related recording (reduces hitching)
REM -------------------------
REM reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
REM reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /t REG_DWORD /d 2 /f
REM reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f
REM reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehavior /t REG_DWORD /d 2 /f

REM -------------------------
REM  6) GPU: Hardware-accelerated GPU scheduling (attempt to enable)
REM      Note: supported only on compatible drivers/GPUs. No harm trying.
REM -------------------------
REM reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f

REM -------------------------
REM  7) Disable unneeded services (stop only here; not permanently disable)
REM     Note: stopping services at runtime reduces immediate resource use.
REM     To permanently disable, change 'sc config <name> start= disabled' (commented out below)
REM -------------------------
echo Stopping services (non-critical for gaming). Some may report errors if missing.
REM sc stop "WSearch"          >nul 2>&1     REM Windows Search (indexing)
REM REM sc stop "SysMain"          >nul 2>&1     REM Superfetch / SysMain
REM sc stop "wuauserv"         >nul 2>&1     REM Windows Update service (stopping only)
REM sc stop "DoSvc"            >nul 2>&1     REM Delivery Optimization
REM sc stop "Spooler"          >nul 2>&1     REM Print Spooler
REM sc stop "bthserv"          >nul 2>&1     REM Bluetooth Support
REM sc stop "WbioSrvc"         >nul 2>&1     REM Biometrics
REM sc stop "CDPSvc"           >nul 2>&1     REM Connected Devices Platform Service
REM sc stop "CDPUserSvc_"      >nul 2>&1     REM per-user CDP instances (wildcards not supported via sc)
REM sc stop "TabletInputService" >nul 2>&1   REM Touch Keyboard and Handwriting Panel
REM sc stop "RetailDemo"       >nul 2>&1
REM sc stop "smartscreen"      >nul 2>&1
REM sc stop "XboxGipSvc"       >nul 2>&1
REM sc stop "XblAuthManager"   >nul 2>&1
REM sc stop "XblGameSave"      >nul 2>&1
REM sc stop "XboxNetApiSvc"    >nul 2>&1

REM -------------------------
REM  8) OPTIONAL: Permanently disable a service (DANGEROUS)
REM  Uncomment only if you know what you do.
REM  Example: to permanently disable Windows Search:
REM sc config "WSearch" start= disabled

REM -------------------------
REM  9) NETWORK: aggressive TCP tuning for lower latency
REM     - disable heuristics, disable autotuning, set CTCP
REM -------------------------
REM netsh interface tcp set heuristics disabled
REM netsh interface tcp set global autotuninglevel=disabled
REM netsh interface tcp set global congestionprovider=ctcp
REM netsh interface tcp set global ecncapability=disabled


REM -------------------------
REM Core parking: aggressive disable
REM https://learn.microsoft.com/en-us/answers/questions/1524213/remove-parked-status-of-cpu
REM reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "Attribute" /t REG_DWORD /d 0 /f

REM -------------------------
REM 13) RAM compression: option to disable (risky)
REM     Disabling memory compression may reduce pagefile overhead but increases RAM usage.
REM     COMMENTED OUT by default. Uncomment only after research and full backups.
REM -------------------------
REM reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisableCompression /t REG_DWORD /d 1 /f

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
REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f
REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscriptionId /t REG_DWORD /d 0 /f

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
REM sc config wuauserv start= disabled

REM ***** DANGEROUS: Disable VBS / HVCI (requires reboot; risk to security)
REM bcdedit /set hypervisorlaunchtype off

REM ***** DANGEROUS: TDR delay increase (can hide GPU crashes)
REM reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDelay /t REG_DWORD /d 10 /f

REM -------------------------
REM 18) Final steps: flush DNS cache and inform user
REM -------------------------
REM ipconfig /flushdns >nul 2>&1
exit
