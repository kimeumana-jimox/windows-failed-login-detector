from pathlib import Path

content = r'''WINDOWS FAILED LOGIN DETECTOR LAB
Extracted PowerShell / Windows commands from the provided lab document.

NOTE:
The document contains screenshots of commands. The beginning of the final detector script is not visible in the supplied screenshots, so it is NOT invented here. The commands below are transcribed from the visible screenshots and text.

============================================================
1. OPEN EVENT VIEWER
============================================================

eventvwr.msc

============================================================
2. EVENT VIEWER FILTERS
============================================================

Event ID 4625  -> Failed logon attempts
Event ID 4624  -> Successful logons

============================================================
3. CREATE SOC LAB EVIDENCE DIRECTORY
============================================================

New-Item -ItemType Directory -Force -Path "C:\SOC-Lab\Evidence"

============================================================
4. CREATE INCIDENT LOG
============================================================

New-Item -ItemType File -Force -Path "C:\SOC-Lab\incident.log"

============================================================
5. LOAD WINDOWS FORMS / DRAWING
============================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

============================================================
6. CAPTURE SCREENSHOT
============================================================

$screen = [System.Windows.Forms.Screen]::PrimaryScreen

$bitmap = New-Object System.Drawing.Bitmap $screen.Bounds.Width, $screen.Bounds.Height

$graphics = [System.Drawing.Graphics]::FromImage($bitmap)

$graphics.CopyFromScreen(
    $screen.Bounds.Location,
    [System.Drawing.Point]::Empty,
    $screen.Bounds.Size
)

$bitmap.Save("C:\SOC-Lab\Evidence\test.png")

$graphics.Dispose()
$bitmap.Dispose()

============================================================
7. DISPLAY SECURITY NOTIFICATION
============================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$notification = New-Object System.Windows.Forms.NotifyIcon
$notification.Icon = [System.Drawing.SystemIcons]::Warning
$notification.Visible = $true

$notification.ShowBalloonTip(
    5000,
    "SOC LAB ALERT",
    "Security event detected!",
    [System.Windows.Forms.ToolTipIcon]::Warning
)

Start-Sleep -Seconds 6
$notification.Dispose()

============================================================
8. DETECTOR INCIDENT RECORD
============================================================

# Create incident record

$message = @"
========================================
SOC LAB SECURITY ALERT
========================================
Time: $(Get-Date)
Event: Multiple failed login attempts
Event ID: 4625
Failed Attempts: $count
Evidence: $screenshot
========================================
"@

Add-Content -Path $LogPath -Value $message

============================================================
9. DETECTOR ALERT NOTIFICATION
============================================================

# Notification

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$notification = New-Object System.Windows.Forms.NotifyIcon
$notification.Icon = [System.Drawing.SystemIcons]::Warning
$notification.Visible = $true

$notification.ShowBalloonTip(
    8000,
    "SOC LAB ALERT",
    "$count failed login attempts detected!",
    [System.Windows.Forms.ToolTipIcon]::Warning
)

Start-Sleep -Seconds 9
$notification.Dispose()

Write-Host "ALERT TRIGGERED!" -ForegroundColor Red
Write-Host "Screenshot: $screenshot"

============================================================
10. DETECTOR THRESHOLD OUTPUT
============================================================

else {
    Write-Host "No threshold reached. Failed attempts in last $WindowMinutes minutes: $count"
}

============================================================
11. SAVE THE DETECTOR SCRIPT
============================================================

'@ | Set-Content "C:\SOC-Lab\detector.ps1"

============================================================
12. RUN THE DETECTOR SCRIPT
============================================================

powershell -ExecutionPolicy Bypass -File "C:\SOC-Lab\detector.ps1"

============================================================
13. TASK SCHEDULER CONFIGURATION
============================================================

The lab configures Windows Task Scheduler to execute the PowerShell detector automatically.

Trigger:
    On an event

Log:
    Security

Event ID:
    4625

The document shows the task being configured to execute the PowerShell program automatically.

============================================================
END
============================================================
'''

path = Path("/mnt/data/windows_failed_login_detector_commands.txt")
path.write_text(content, encoding="utf-8")

print(f"Created: {path}")
