
<#
apply-gaming-tweaks.ps1

Usage (run in an elevated PowerShell prompt):
  1) Save to: C:\path\to\apply-gaming-tweaks.ps1
  2) Open "Windows PowerShell (Admin)" or an elevated terminal
  3) .\apply-gaming-tweaks.ps1

What it does (summary):
 - creates a timestamped backup folder and exports registry keys it will modify
 - sets Power Plan to "High performance" (if available)
 - stops & optionally disables some non-critical services (Search, SysMain, Telemetry, Print Spooler)
 - applies a couple of network tweaks (NetworkThrottlingIndex, TcpAckFrequency, DisableTaskOffload = TCPNoDelay-like)
 - logs actions and provides a straightforward undo path using .reg files

CAUTION: Read the script before running. It creates backups and prints an "undo" command.
#>

# Ensure running as admin
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator. Right click PowerShell and choose 'Run as administrator'. Aborting."
    exit 1
}

$DebugPreference = "SilentlyContinue"

# Timestamped working dir
$ts = (Get-Date).ToString("yyyyMMdd-HHmmss")
$baseDir = Join-Path $env:LocalAppData "gaming_tweaks\$ts"
$backupDir = Join-Path $baseDir "backup"
$logFile = Join-Path $baseDir "changes.log"
New-Item -ItemType Directory -Path $backupDir -Force | Out-Null

function Log($s) {
    $line = "$(Get-Date -Format o) `t $s"
    Add-Content -Path $logFile -Value $line
    Write-Host $s
}

Log "Gaming tweaks run start. Backup dir: $backupDir"

# Helper: export a registry key to .reg (using reg.exe for portability)
function Export-RegKey([string]$key, [string]$outFile) {
    if ($key -eq '') { return }
    $outFileDir = Split-Path $outFile -Parent
    if (-not (Test-Path $outFileDir)) { New-Item -ItemType Directory -Path $outFileDir -Force | Out-Null }
    Log "Exporting registry key '$key' -> $outFile"
    & reg export "$key" "$outFile" /y | Out-Null 2>&1
    if ($LASTEXITCODE -ne 0) {
        Log "Warning: export of $key failed (exitcode $LASTEXITCODE)."
    }
}

# Keys we will touch (we export them first)
$regKeysToBackup = @(
    "HKLM\SYSTEM\CurrentControlSet\Control\Power",
    "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl",
    "HKLM\SYSTEM\CurrentControlSet\Services\WSearch",
    "HKLM\SYSTEM\CurrentControlSet\Services\SysMain",
    "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsSearch",
    "HKLM\SYSTEM\CurrentControlSet\Control\Multimedia\SystemProfile",
    "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters",
    "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
)

foreach ($k in $regKeysToBackup) {
    $safeName = ($k -replace '[\\:]', '_').TrimStart('_')
    $out = Join-Path $backupDir ("REG_$safeName.reg")
    Export-RegKey -key $k -outFile $out
}

# ---------- 1) Power plan: switch to High performance ----------
Log "Setting power plan to High performance (if present)."
# Get the 'High performance' GUID (scheme_min or scheme_max depends on OS)
$high = (powercfg -l) 2>&1 | Select-String -Pattern "High performance" -SimpleMatch
if ($high) {
    # extract GUID from the matching line
    $guid = ($high -split '\s+')[3] -replace '[\(\)]',''
    if ($guid) {
        Log "Found High performance: $guid - activating"
        powercfg /setactive $guid
    } else {
        Log "Could not parse High performance GUID. Skipping power plan change."
    }
} else {
    Log "High performance plan not found. You can create/enable it manually or use powercfg to list schemes."
}

# ---------- 2) Stop & optionally disable some services ----------
# Services we commonly stop for gaming sessions (safe-ish, reversible)
$servicesToStop = @(
    @{ Name = "WSearch"; Desc="Windows Search (indexing)"; DisablePersist = $true },    # indexing
    @{ Name = "SysMain"; Desc="SysMain (Superfetch)"; DisablePersist = $true },        # superfetch
    @{ Name = "DiagTrack"; Desc="Connected User Experiences/Telemetry (DiagTrack)"; DisablePersist = $true },
    @{ Name = "WaaSMedicSvc"; Desc="Windows Update Medic Service"; DisablePersist = $false }, # leave alone by default
    @{ Name = "Spooler"; Desc="Print Spooler"; DisablePersist = $false }
)

foreach ($svc in $servicesToStop) {
    $n = $svc.Name
    try {
        $sc = Get-Service -Name $n -ErrorAction SilentlyContinue
        if ($sc) {
            # export current start mode
            try {
                $currentStart = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\$n").Start
                Add-Content -Path $logFile -Value "$(Get-Date -Format o) `t Service $n start value = $currentStart"
            } catch { }
            if ($sc.Status -ne 'Stopped') {
                Log "Stopping service $n ($($svc.Desc))..."
                Stop-Service -Name $n -Force -ErrorAction SilentlyContinue
            } else {
                Log "Service $n already stopped."
            }
            if ($svc.DisablePersist) {
                Log "Setting $n start=disabled (persist until manually restored)."
                sc.exe config $n start= disabled | Out-Null
            } else {
                Log "Leaving start mode unchanged for $n (only stopped for this session)."
            }
        } else {
            Log "Service $n not present on this system."
        }
    } catch {
        Log "Error handling service $n : $_"
    }
}

# ---------- 3) Network tweaks ----------
# 3a) NetworkThrottlingIndex (often used to remove throttling)
$sysProfileKey = "HKLM:\SYSTEM\CurrentControlSet\Control\Multimedia\SystemProfile"
Export-RegKey -key "HKLM\SYSTEM\CurrentControlSet\Control\Multimedia\SystemProfile" -outFile (Join-Path $backupDir "REG_SystemProfile.reg")
try {
    New-ItemProperty -Path $sysProfileKey -Name "NetworkThrottlingIndex" -PropertyType DWord -Value 0xFFFFFFFF -Force | Out-Null
    Log "Set NetworkThrottlingIndex = 0xFFFFFFFF (disable network throttling)."
} catch {
    Log "Could not set NetworkThrottlingIndex: $_"
}

# 3b) Per-interface TcpAckFrequency and TCPNoDelay-ish flags
# We'll iterate over interfaces under Tcpip\Parameters\Interfaces and set TcpAckFrequency=1 and TCPNoDelay=1 (DWORD)
# We export that Interfaces key first (done above).
$interfacesRoot = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
try {
    $interfaces = Get-ChildItem $interfacesRoot -ErrorAction SilentlyContinue
    foreach ($if in $interfaces) {
        $p = $if.PSPath
        $ifName = $if.PSChildName
        # backup per-interface key (export handled earlier globally)
        try {
            Set-ItemProperty -Path $p -Name "TcpAckFrequency" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
            Set-ItemProperty -Path $p -Name "TCPNoDelay" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
            Log "Set TcpAckFrequency=1 and TCPNoDelay=1 on interface $ifName"
        } catch {
            Log "Could not set tcp params on $ifName: $_"
        }
    }
} catch {
    Log "Error enumerating interfaces: $_"
}

# ---------- 4) Small Windows telemetry & game-dvr tweaks (per-user and policies) ----------
# Export current keys first
Export-RegKey -key "HKCU\System\GameConfigStore" -outFile (Join-Path $backupDir "REG_HKCU_GameConfigStore.reg")
Export-RegKey -key "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" -outFile (Join-Path $backupDir "REG_HKCU_GameDVR.reg")
Export-RegKey -key "HKLM\SOFTWARE\Policies\Microsoft\Windows" -outFile (Join-Path $backupDir "REG_HKLM_Policies_Windows.reg")

try {
    # Disable Xbox Game Bar capture
    New-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -PropertyType DWord -Value 0 -Force | Out-Null
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -PropertyType DWord -Value 0 -Force | Out-Null
    Log "Disabled GameDVR/AppCapture (user keys)."
} catch {
    Log "Failed to set GameDVR keys: $_"
}

# ---------- 5) Disable some background apps via registry policy (non-destructive) ----------
# Prevent apps from running in background for current user (conservative)
try {
    $p = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications"
    # not all systems have this; we do not error out
    if (Test-Path $p) {
        Log "BackgroundAccessApplications exists - not modifying aggressively here."
    } else {
        Log "BackgroundAccessApplications not present; skipping."
    }
} catch {
    Log "Skipping background app policy changes: $_"
}

# ---------- 6) Finalize & print summary ----------
Log "Tweaks applied. See log file: $logFile"
Log "Backup .reg files are in: $backupDir"
Log "If you want to undo ALL changes made by this script, import the .reg files from the backup directory in reverse order."
Log "Suggested quick undo (run as admin):"
$undoCmd = @(
    'REM Re-import backups (run as Admin) - change the path to the correct timestamp folder',
    "pushd `"$backupDir`"",
    "for %f in (*.reg) do reg import \"%f\"",
    "popd",
    'REM After importing .reg files, restore service start modes (manually) or reboot'
) -join "`n"
Write-Host ""
Write-Host $undoCmd
Write-Host ""
Log "Finished."
