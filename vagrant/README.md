
From fresh image
================
- install vbox tools and remove iso
- set any pre settings (keyboard layout, windows settings)
- add fw rule?

Configure WinRS
===============
#http://huestones.co.uk/node/305


winrm quickconfig -q 
winrm set winrm/config/winrs @{MaxMemoryPerShellMB="512"} 
winrm set winrm/config @{MaxTimeoutms="1800000"} 
winrm set winrm/config/service @{AllowUnencrypted="true"} 
winrm set winrm/config/service/auth @{Basic="true"} 
sc config WinRM start= auto

#http://www.hurryupandwait.io/blog/understanding-and-troubleshooting-winrm-connection-and-authentication-a-thrill-seekers-guide-to-adventure
port: 5986
netsh advfirewall firewall add rule name="WinRM-HTTP" dir=in localport=5985 protocol=TCP action=allow
netsh advfirewall firewall add rule name="WinRM-HTTP" dir=in localport=5986 protocol=TCP action=allow

#on the hypervisor
winrm set winrm/config/client @{TrustedHosts="192.168.56.101"}

#http://www.techdiction.com/2016/02/11/configuring-winrm-over-https-to-enable-powershell-remoting/
powershell (admin):
# on the hypervisor (?)
New-SelfSignedCertificate -DnsName MSEDGEWIN10 -CertStoreLocation Cert:\LocalMachine\My
New-SelfSignedCertificate -DnsName 192.168.56.101 -CertStoreLocation Cert:\LocalMachine\My

output:
Thumbprint                                Subject
----------                                -------
A611EC160EF439BB536F0D5BF92AF0F62F93409E  CN=MSEDGEWIN10

cmd (admin):
winrm create winrm/config/Listener?Address=*+Transport=HTTPS @{Hostname="MSEDGEWIN10"; CertificateThumbprint="A611EC160EF439BB536F0D5BF92AF0F62F93409E"}
winrm create winrm/config/Listener?Address=*+Transport=HTTPS @{Hostname="192.168.56.101"; CertificateThumbprint="A611EC160EF439BB536F0D5BF92AF0F62F93409E"}



Create base image
=================

vagrant package --base "MSEdge - Win10_preview" --output windows.box --vagrantfile Vagrantfile



Create new instance
===================

pushd d:\VM\VBox\
mkdir test001
cd test001\

vagrant box add windows.box --name test001
vagrant init test001
vagrant up