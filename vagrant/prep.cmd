@rem change keyboard layout
@rem http://www.capri-technology.be/en/blog/set-keyboard-layout-powershell
@rem Set-WinUserLanguageList -LanguageList de-DE -Force -Confirm:$false

@rem @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

@powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-WinUserLanguageList -LanguageList de-DE -Force -Confirm:$false"

cmd.exe /c winrm quickconfig -q
cmd.exe /c winrm set winrm/config/winrs @{MaxMemoryPerShellMB="512"} 
cmd.exe /c winrm set winrm/config @{MaxTimeoutms="1800000"} 
cmd.exe /c winrm set winrm/config/service @{AllowUnencrypted="true"} 
cmd.exe /c winrm set winrm/config/service/auth @{Basic="true"} 
sc config WinRM start= auto

netsh advfirewall firewall add rule name="WinRM-HTTP" dir=in localport=5985 protocol=TCP action=allow

reg add HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /d 0 /t REG_DWORD /f /reg:64


