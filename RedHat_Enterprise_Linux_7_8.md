# Installing Red Hat Enterprise Linux 7.6 or 8.3+

The following guide is primarily to install RHEL 7.6 in a VirtualBox environment. This guide may also be used to install RHEL 8.x (with DNF commands) and installed in any other hypervisor environment (e.g. KVM) so steps may not apply.

NOTE: Using VirtualBox and RHEL 7.6 Binary DVD ISO. MUST HAVE redhat account to use yum commands (or dnf commands for 8+)

## Installation

    Create RHEL VM with enough hard drive space (20GB should be enough). In VM settings, set Mouse to use USB tablet option.

* Date & Time - Change time zone to Central time
* Software Selection - Change to Server with GUI and select other packages on right side. I just selected Development option
* Network & Hostname - Turn Ethernet to on
* Installation Destination - Select the only hard drive option
* Begin Installation


* Root Password - Add a root password
* (Optional) User Creation - Add username and password. I added one so I don't do something stupid with root

## Post Installation Setup

* Login as root by selecting other user option.
* If successful, select top right hand corner, then root, then log out.
* Log back in using root
* NOTE: This is done because of a bug with RHEL and Virtualbox that only allows clicking in a single application and menus outside the app doesn't work. This should be tested again in a future VirtualBox release if this is still an issue then update steps here to reflect.
* Open Terminal by selecting Applications Menu, then Terminal.
* The following commands will be needed, will break down by package installs (NOTE: the commands will be preceded by [root@localhost] so this will not need to be typed out)

### Register VM

* To register VM so commands such as yum can be used, the following command is needed:

[root@localhost] subscription-manager register --username $username --password $password --auto-attach

where $username and $password are your credentials used to login to your redhat account.

* If the above command throws HTTP 401 error,generate an activation key from the article (https://access.redhat.com/articles/1378093) and run the following commands:

[root@localhost] subscription-manager register --org=$ORG_ID --activationkey=$Key_Name

where $ORG_ID and $KEY_NAME are the organization ID, which is a number, and a key name that you specify when you create a key. You may also use the Subscription manager GUI and provide the login (email address) and password.

* Run the following command to update RHEL:

[root@localhost] yum update

or (RHEL 8)

[root@localhost] dnf update

* And enable extras and optional RPMs:

[root@localhost] yum-config-manager --enable rhel-7-server-extras-rpms
[root@localhost] subscription-manager repos --enable rhel-7-server-optional-rpms

or (RHEL 8)

[root@localhost] sudo subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms
[root@localhost] sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm


* (Optional) If you created a non-root user during install, run the following command to allow user to run root-only commands using sudo:

[root@localhost] usermod -aG wheel $user

where $user is the non-root user

* If installing on VirtualBox, there will be issues with the mouse not working (at least on 6.0.4). It will require a kernel update (and another yum update):

[root@localhost] yum update kernel

### Install Docker CE

* Running yum update should handle any required packages (see Reference below for more info)
* Add stable repo:

[root@localhost] yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

* Install latest version of Docker CE and containerd and docker-compose

[root@localhost] yum install -y docker-ce docker-ce-cli containerd.io docker-compose

or 

[root@localhost] yum install -y docker docker-compose

* Installing Docker (not docker CE) will resolve issues with installing packages in containers

* Start Docker Service

[root@localhost] systemctl start docker

* To automatically start docker when VM turns on, run the following:

[root@localhost] systemctl enable docker

* (Optional) If you created a non-root user, add to docker group so docker can be run without sudo (create docker group first):

[root@localhost] sudo groupadd docker
[root@localhost] sudo usermod -aG docker $user

where $user is the non-root user. Restart for changes to be applied.


** Reference: https://docs.docker.com/install/linux/docker-ce/centos/
** && https://docs.docker.com/engine/install/linux-postinstall/

### Install Docker EE
 
* TODO Install Docker EE and write steps for install. Docker CE needs to be uninstalled if installed
** Reference: https://docs.docker.com/v17.12/install/linux/docker-ee/rhel/


### Install using YUM or RPM (DNF for RHEL 8)

* Commands will be installed via yum if it exists in the RHEL repos

e.g.

[root@localhost] yum install -y vim

* To find packages available, start typing the press tab twice to see any available packages from the RHEL repo

* If you can't find the repo via yum, you need to download the RPM file and then run the following RPM command:

[root@localhost] rpm -Uvh google-chrome-stable_current_x86_64.rpm

* Packages to install using Yum

maven
nodejs (curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash - && yum install nodejs)
vscode:
* sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
* yum check-update
* yum install code

powershell (curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo && sudo yum install -y powershell)
Azure Data Studio (wget https://go.microsoft.com/fwlink/?linkid=2083326 > azuredatastudio.rpm && yum install -y azuredatastudio.rpm && azuredatastudio)

### Install OpenVPN

* Run the following commands to install:

[root@localhost] yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
[root@localhost] yum update
[root@localhost] yum install -y openvpn easy-rsa
[root@localhost] yum install -y NetworkManager-openvpn-gnome.x86_64

* You can import a .ovpn file by going to top right hand corner, click the power button, click Wired Connected, then Wired Settings
* Select + sign under VPN section and select Import from file
* Once imported, add username, and keep password blank. Click the icon on right side of password text box and select Ask for password every time

### Install Google Chrome

* Create new repo

[root@localhost] vim /etc/yum.repos.d/google-chrome.repo

* Add the following entry:

```
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
```

* Install Google Chrome

[root@localhost] dnf install -y google-chrome-stable

### Install Sublime Text

* Grab keys

[root@localhost] rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg


* Download repo

[root@localhost] wget https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo

* Install Sublime Text

[root@localhost] dnf install -y sublime-text

### Install Plank

* Grab plank rpm

[root@localhost] wget http://li.nux.ro/download/nux/dextop/el7/x86_64/plank-0.6.0-3.el7.nux.x86_64.rpm


* Get dependencies

Some found here:
http://li.nux.ro/download/nux/dextop/el7/x86_64/

* Install Plank

[root@localhost] sudo rpm -ivh plank.rpm


### Install Sublime Text

Follow this for registering:

https://steemit.com/technology/@horpey/activate-lastest-sublime-text-build-3211-for-free

For version 3211:

Add to host file:

```
127.0.0.1 www.sublimetext.com
127.0.0.1 sublimetext.com
127.0.0.1 sublimehq.com
127.0.0.1 license.sublimehq.com
127.0.0.1 45.55.255.55
127.0.0.1 45.55.41.223
0.0.0.0 license.sublimehq.com
0.0.0.0 45.55.255.55
0.0.0.0 45.55.41.223
```

Use license:

```
----- BEGIN LICENSE -----
Member J2TeaM
Single User License
EA7E-1011316
D7DA350E 1B8B0760 972F8B60 F3E64036
B9B4E234 F356F38F 0AD1E3B7 0E9C5FAD
FA0A2ABE 25F65BD8 D51458E5 3923CE80
87428428 79079A01 AA69F319 A1AF29A4
A684C2DC 0B1583D4 19CBD290 217618CD
5653E0A0 BACE3948 BB2EE45E 422D2C87
DD9AF44B 99C49590 D2DBDEE1 75860FD2
8C8BB2AD B2ECE5A4 EFC08AF2 25A9B864
------ END LICENSE ------
```

### Install Themes and Icons

* Create a .themes and .icons folder in your home directory

[root@localhost] cd
[root@localhost] mkdir .themes .icons

* Download themes in the .themes folder and the icons in the .icons folder. Make changes to themes and icons in Tweaks program in Applications > Accessories > Tweaks

** Examples of themes I am using:

[root@localhost] cd ~/.themes
[root@localhost] git clone https://github.com/thiagolucio/OSX-Arc-Shadow

** Example of Icons I am using:

* Run the following commands:

[root@localhost] cd ~/.icons
[root@localhost] git clone https://github.com/horst3180/arc-icon-theme

### Add Repos

Create a .repo file under /etc/yum.repos.d

### Install OpenSSL 1.1.1+

RHEL7 only installs 1.0.2k but the Blowfish cipher (BF-CBC) is missing in the install due to the SWEET32 vulnerability. BF-CBC is needed to connect to the OpenVPN configuration. We will need to install the latest OpenSSL from source.

Grab OpenSSL from source:

https://www.openssl.org/source/

Follow article to install from source:

https://www.tecmint.com/install-openssl-from-source-in-centos-ubuntu/

After running install, add the line "include /usr/local/lib64/*" to /etc/ld.so.conf and run "sudo ldconfig". Run "openssl version" to confirm proper install.

From article:
https://github.com/openssl/openssl/issues/3993#issuecomment-351595443

### Connecting to Samba shares

#Connect to Samba Share
smbclient //HOSTNAME.DOMAIN/FOLDER -U 'DOMAIN\user.name'

#mount samba share from windows onto linux (run 'yum install cifs-utils')
mount -t cifs //HOSTNAME.DOMAIN/FOLDER -o username=user.name,password=password123 /tmp/util01

