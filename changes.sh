#!/usr/bin/env sh

function updateSystem {
  apt -y update
  apt -y dist-upgrade
  apt -y autoremove
  snap refresh
}

function updateFlatpaks {
  flatpak update
}

function addRepositories {
  add-apt-repository -ys 'deb http://archive.canonical.com/ubuntu focal partner'
  add-apt-repository -ys 'http://dl.google.com/linux/chrome/deb/'
  add-apt-repository -y 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main'
  add-apt-repository -y 'https://deb.etcher.io stable etcher'
  add-apt-repository -y ppa:lutris-team/lutris
}

# add ppa repositories
updateSystem
addRepositories
apt -y updatebalena-etcher-electron

# change snapstore to gnome software and add flathub as source
apt -y install gnome-software gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
snap remove snap-store

# add packages

# systemtools
apt -y install git vim ssh gdebi balena-etcher-electron gnome-boxes
snap install p7zip-desktop
# extensions
apt -y install gnome-shell-extension-gsconnect gnome-shell-extension-gsconnect-browsers gnome-tweaks
# internet/communications
apt -y install chromium-browser evolution
snap install walc
flatpak install flathub org.telegram.desktop
flatpak install flathub org.signal.Signal
# entertainment
apt -y wine steam-installer lutris
snap install obs-studio
flatpak install flathub com.teamspeak.TeamSpeak
snap install spotify

# remove packages
apt -y remove firefox thunderbird

updateSystem