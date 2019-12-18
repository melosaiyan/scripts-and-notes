# Linux Install Notes

## Solus 4

1. Installation Tips for Solus on VMware
   * Installing VMware tools:
      * [Solus Reddit Thread](https://www.reddit.com/r/SolusProject/comments/49t016/anyone_succesfully_installed_solus_on_a_vmware_vm/)

      * [Open VM Tools Wiki](https://wiki.archlinux.org/index.php/VMware/Installing_Arch_as_a_guest)
         * Use this to get open-vm-tools: [GitHub](https://github.com/vmware/open-vm-tools)

         * Install Build Essentials: 
               ```
               eopkg it -c system.devel
               ```

         * Install Linux headers: 
              ```
               eopkg install -y linux-headers linux-current-headers
              ```

         * Update Linux-Header location (For ln command, -f is update, -n is directory):
             ```
             cd /lib/modules/4.20.16-112.current
             ln -sfn /usr/src/linux-headers-5.0.5-113.current build
             ```

         * Install missing devel packages: 
             ```
             eopkg install -y libmspack libmspack-devel libx11-devel libxext-devel libxinerama-devel libxi-devel xerces-c-devel libxrender-devel libxrandr-devel libxtst-devel libgtk-2-devel libgtkmm-2-devel procps-ng-devel libdnet-devel xmlsec1-devel libgtkmm-3-devel
             ```

         * Install linux-headers: eopkg install linux-headers

         * Run auto reconfigure: `autoreconf -i`

         * Run Build (as root)
             ```
             ./configure --without-kernel-modules
             make
             make install
             ```

         * Install Open-VM-Tools: `eopkg install -y open-vm-tools`

   * Install QMMP

      * Install QT5 stuff: `eopkg install -y qt5-base-devel qt5-tools-devel qt5-x11extras-devel qt5-multimedia-devel`

      * Install Codec dependencies: 
          ```
          eopkg install -y libogg-devel \
        ​	libvorbis-devel \
        ​	enca-devel \
        ​	libsndfile-devel \
        ​	wavpack-devel \
        ​	libmpeg2-devel \
        ​	libmad-devel \
        ​	mpg123-devel \
        ​	alsa-lib-devel \
        ​	libavc1394-devel \ 
        ​	libcdio-devel \ 
        ​	opus-devel \ 
        ​	opusfile-devel
          ```

      * Change CMakeLists.txt to change location of CMAKE to QMAKE /usr/lib/qmake

      * Restart PC

      * Run build (as root)
          ```
          cmake ./ -DMAKE_INSTALL_PREFIX=/usr
          make
          make install
          ```

   * Install useful apps

      * Linux tools: eopkg install -y vim rsync openssh openssh-server
      * Docker: eopkg install -y docker (or eopkg install docker mbedtls-devel fuse-devel)
         * sudo systemctl start docker
         * sudo ststemctl enable docker
         * sudo usermod -ag docker <user>
      * Pidgin: eopkg install -y pidgin pidgin-sipe
         * Add Skype for Business Login:
            * In Basic tab, Add full email address to Username. Keep Login and Password blank
            * In Advanced Tab, in the Server[:Port] field enter sipdir.online.lync.com:443 and in User Agent enter UCCAPI/16.0.6965.5308 OC/16.0.6965.2117
            * Keep all other settings the same
         * Enable Login and put in password
         * Reference: https://opensource.com/article/18/4/pidgin-open-source-replacement-skype-business
      * Opera: eopkg install -y opera-stable
      * VSCode: eopkg install -y vscode
      * NTFS-3G (Installed version is old or corrupt): `eopkg remove ntfs-3g && eopkg it -y ntfs-3g`
      * Virt-Manager:
        ```
        Install packages:
        eopkg install -y qemu libvirt virt-manager spice virglrenderer virt-viewer
        start libvirtd
        systemctl enable libvirtd
        systemctl start libvirtd
        ```
      * Install via Software Center
         * Google Chrome
         * Slack
         * Spotify
         * Virtualbox-current

2. Useful commands

   1. `eopkg search <string>`

3. Build Solus Packages

   1. Install Solbuild: `sudo eopkg install -y git solbuild arcanist solbuild-config-unstable`
   2. Update: `sudo eopkg update`
   3. [Solus Packaging Tutorial](https://getsol.us/articles/packaging/)
4. Things to run after kernel updates
    1. Re-install wireless card:
    2. dkms status
    3. dkms remove $name/$version --all
    4. dkms add $name/$version
    5. dkms install $name/$version
    6. VMware script (**TODO add steps!**)

## Fedora 30

Install:

`dnf install gnome-tweaks-tool`

Links:

* Shell Extensions (Install to ~/.local/share/gnome-shell/extensions and make extensions folder the UUID from metadata.json): 
[Arc Menu](https://extensions.gnome.org/extension/1228/arc-menu/)
[Dash to Panel](https://extensions.gnome.org/extension/1160/ash-to-panel/)
[Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)

* Themes (Install to ~/.themes)
(McOs Theme)(https://github.com/paullinuxthemer/Mc-OS-themes)

* Icons (Install to ~/.icons)
[La Capitaine Icons](https://github.com/keeferrourke/la-capitaine-icon-theme)

* Fonts (Copy to /usr/share/fonts/ and then fc-cache -v -f)
[Ubuntu Fonts](https://design.ubuntu.com/font/)

* Transparent Panel:
[Dynamic Toolbar](https://github.com/AMDG2/GnomeShell_DynamicTopBar)
* [How to make Gnome Shell Panel Translucent](https://ask.fedoraproject.org/en/question/28653/how-can-i-make-the-gnome-shell-top-bar-translucent-transparent/)
* Available Environments:

  ```
  dnf grouplist -v
  dnf install -y @cinnamon-desktop-environment
  ```

### Important Commands

* Install Snaps

  ```
  dnf install snapd
  ln -s /var/lib/snapd/snap /snap
  snap install slack --classic
  ```
  
## Manjaro XFCE

* [Install Compiz with Prefix](http://wiki.compiz.org/Installation/CompileGuide)
* [Install Compiz in this order](https://forum.manjaro.org/t/how-to-install-compiz-reloaded-on-manjaro/4212)
* [GitHub for Compiz](https://github.com/compiz-reloaded)
* Before installing Emerald, change configure.ac and remove `decor_ver` if statements and set `decor_ver=0`, and change src/main.c and add `#define DECOR_INTERFACE_VERSION 20110504`, replacing variable set to 0
* Before compiling, do export `export PKG_CONFIG_PATH=/opt/compiz/lib/pkgconfig:/opt/compiz/share/pkgconfig`
* Install Cython if missing: `pacman -S --noconfirm cython cython2`
* Install protobuf in all forms `pacman -S --noconfirm protobuf`
* Add Python Path to make CCSM work: `echo "export PYTHONPATH=/opt/compiz/lib/python3.7/site-packages" >>/etc/bash.bashrc` or /etc/profile
* Add appendpath of /opt/compiz/bin to add Compiz executables to /etc/profile
* Create script and add to crontab:
  ```
  echo "compiz --replace ccp" > /opt/compiz/compiz_start.sh && chmod +x /opt/compiz/compiz_start.sh
  crontab -e (@reboot sh /opt/compiz/compiz_start.sh)
  ```
* Enable Window Decoration and in terminal, type `emerald --replace`
* To use theme manager, type `emerald-theme-manager > /dev/null 2>&1 &`

## Antergos

* zsh install
  - Install zsh (e.g. pacman -S zsh)
  - Create .zshrc file: `echo "#Initial Comment" >> ~/.zshrc`
  - Install Oh My Zsh: `sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"`
  - Reference for [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)
  - Check current shell: `echo $0` 
  - Add new plugins to: plugins=(... extract history sublime sudo web-search) in ~/.zshrc
  - Add Custom plugins: `~/.oh-my-zsh/custom/plugins && git clone https://github.com/zsh-users/zsh-syntax-highlighting && git clone https://github.com/zsh-users/zsh-autosuggestions`
  - Add `zsh-autosuggestions` and `zsh-syntax-highlighting` to plugins 
  - Add to ~/.bashrc: 
    
      ```
      export SHELL=`which zsh` 
      [ -z "$ZSH_VERSION"] && exec "$SHELL" -l
      ```
* vim usage
  - yy to yank current line including \n, y$ to yank line without new line (or select lines in visual mode)
  - 3yy to select next 3 lines
  - p to paste
* Clipboard managers
  - [Clipped for Debian based](https://github.com/davidmhewitt/clipped)
* Install XFCE
  - https://www.archlinuxuser.com/2013/05/how-to-install-xfce-dekstop-environment.html

## Arch notes

Installing bootloader:

* Mount root directory to /mnt and mount EFI partition to /mnt/boot

  - mount /dev/nvme0n1p7 /mnt
  - mkdir /mnt/boot
  - mount /dev/nvme0n1p2 /mnt/boot
  - arch-chroot /mnt
  - pacman -S grub os-prober
  - grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
    //Make sure Linux is installed before running grub, img files need to exist in the EFI partition! if doing offline, go to /var/cache and find linux tar.xz
  - grub-mkconfig -o /boot/grub/grub.cfg
    //Note: Must use Arch ISO in UEFI mode to load EFI modules to do grub-install; arch boot strap is not enough TODO: find way to use arch bootstrap with EFI

* Wifi

  - Install driver via dkms and also install iw and wpa_suplicant
  - Follow instructions on wpa_supplicant on arch to connect to wifi
from https://github.com/zebulon2/rtl8814au.git

* Arch Nvidia install

  - install nvidia-dkms using yay (instead of nvidia)
  - Use linux v. 5.2 for wifi support (use gcc libs dated before sept 2019)

## General Linux Tasks

Add Mounting Script:
VirtualBox: `sudo mount -t vboxsf -o uid=1000,gid=1000 workspace /home/melosaiyan/share`
or
VMware: `sudo vmhgfs-fuse -o allow_other -o auto_unmount .host:/workspace ~/share`

Add mounting in fstab: TODO

* Add Compiz to Elementary OS: https://elementaryos.stackexchange.com/questions/2591/can-you-install-compiz-on-elementary-os/14497#14497
* Add Pacman progress bar: https://github.com/xeBuz/pacman-progressbar
