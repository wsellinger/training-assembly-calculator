# launch-easy68k.ps1
# Opens the given file in Easy68K, then sends F9 to assemble.
# If Easy68K is already running, focuses the existing window instead of opening a new instance.

param(
    [string]$File
)

$exe = "C:\Program Files\EASy68K\EDIT68K.exe"
$procName = "EDIT68K"

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class WinApi {
    [DllImport("user32.dll")]
    public static extern bool SetForegroundWindow(IntPtr hWnd);
    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
}
"@

$existing = Get-Process -Name $procName -ErrorAction SilentlyContinue

if ($existing) {
    $hwnd = $existing[0].MainWindowHandle
    [WinApi]::ShowWindow($hwnd, 9)   # SW_RESTORE
    [WinApi]::SetForegroundWindow($hwnd)
} else {
    Start-Process -FilePath $exe -ArgumentList "`"$File`""
    # Wait for Easy68K to finish loading before sending F9
    Start-Sleep -Milliseconds 1500
}

# Send F9 (Assemble Source)
$wsh = New-Object -ComObject WScript.Shell
$wsh.SendKeys("{F9}")
