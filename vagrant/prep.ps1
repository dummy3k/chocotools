#change keyboard layout
#http://www.capri-technology.be/en/blog/set-keyboard-layout-powershell
#de-DE
Set-WinUserLanguageList -LanguageList de-DE -Force -Confirm:$false

winrm quickconfig -q 
winrm set winrm/config/winrs @{MaxMemoryPerShellMB="512"} 
winrm set winrm/config @{MaxTimeoutms="1800000"} 
winrm set winrm/config/service @{AllowUnencrypted="true"} 
winrm set winrm/config/service/auth @{Basic="true"} 
sc config WinRM start= auto
