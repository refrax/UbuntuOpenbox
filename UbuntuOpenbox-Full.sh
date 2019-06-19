#!/bin/bash

bypass() {
  sudo -v
  while true;
  do
    sudo -n true
    sleep 45
    kill -0 "$$" || exit
  done 2>/dev/null &
}

readonly txt1="Updating..."
readonly txt2="Installing..."
readonly txt3="Configuring..."
readonly txt4="Done!"
readonly txt5="Press ENTER to reboot."

bypass

clear
  printf "$txt1\n\n"
  sleep 3s
    sudo apt -y update
    sudo apt -y upgrade

clear
  printf "$txt2\n\n"
  sleep 3s
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
	sudo addgroup netdev
    sudo usermod -a -G netdev $USER
    sudo usermod -a -G video $USER
    sudo apt -y install adwaita-icon-theme-full apturl arc-theme brightness-udev brightnessctl calibre compton conky-all cpufrequtils cups cups-daemon curl dmz-cursor-theme firefox fonts-croscore fonts-hack fonts-lato fonts-firacode fonts-noto-color-emoji fonts-ubuntu fonts-vollkorn galculator galternatives gdebi geany geoclue-2.0 gigolo git gnome-disk-utility gsimplecal gtk-update-icon-cache gtk3-nocsd gufw gvfs hardinfo htop imagemagick keepassxc language-selector-gnome libgdk-pixbuf2.0-dev libglib2.0-dev libxml2-utils light-locker light-locker-settings lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings linux-tools-generic lsb-release mesa-utils macchanger mesa-utils-extra mesa-vulkan-drivers neofetch network-manager nitrogen numix-gtk-theme numlockx obconf obmenu obsession openbox optipng orage smplayer papirus-icon-theme pavucontrol plymouth-theme-ubuntu-logo plymouth-theme-ubuntu-text policykit-1-gnome redshift-gtk ristretto ruby-sass scrot simple-scan software-properties-gtk synaptic system-config-printer thunar thunar-archive-plugin thunar-volman tint2 transmission-gtk tumbler tumbler-plugins-extra ubuntu-drivers-common ubuntu-restricted-addons ubuntu-restricted-extras unar update-manager volumeicon-alsa wget xarchiver xbacklight xcalib xdg-user-dirs-gtk xdg-utils xdotool xdotool xfce4-appfinder xfce4-battery-plugin xfce4-clipman xfce4-goodies xfce4-notifyd xfce4-power-manager xfce4-settings xiccd xinit xorg xpdf xserver-xorg xz-utils
    sudo apt -y install $(check-language-support)

clear
  printf "$txt3\n\n"
  sleep 3s
    sudo systemctl stop snapd.service snapd.seeded.service snapd.socket
    sudo systemctl disable snapd.service snapd.seeded.service snapd.socket
	sudo update-alternatives --set x-session-manager /usr/bin/openbox-session
    cp crubuntung-files.tar.xz /tmp
    cd /tmp
    tar Jxvf crubuntung-files.tar.xz
    chmod +x crubuntung-files/etc/skel/.bin/crubuntung-scripts/*
    mv -f crubuntung-files/english-conkyrc crubuntung-files/etc/skel/.conkyrc
    mv -f crubuntung-files/english-menu.xml crubuntung-files/etc/skel/.config/openbox/menu.xml
    \cp -r crubuntung-files/etc/skel/. ~/
    sudo \cp -r crubuntung-files/etc/. /etc
    sudo \cp -r crubuntung-files/usr/. /usr
    rm -rf crubuntung-files/
    mkdir ~/.crubuntung-backup/
	mv crubuntung-files.tar.xz ~/.crubuntung-backup/
    cp -r /usr/share/icons/Papirus/ /usr/share/themes/Numix/ ~/.crubuntung-backup/

    # Install UNIMATRIX
    sudo curl -L https://raw.githubusercontent.com/will8211/unimatrix/master/unimatrix.py -o /usr/local/bin/unimatrix
    sudo chmod a+rx /usr/local/bin/unimatrix

    # install youtube-dl
    sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
    sudo chmod a+rx /usr/local/bin/youtube-dl

clear
  printf "$txt4\n\n"
read -p "$txt5"
systemctl reboot
