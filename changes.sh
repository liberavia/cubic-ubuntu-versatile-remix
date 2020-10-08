#!/usr/bin/env sh

function updateSystem {
  apt -y update
  apt -y dist-upgrade
  apt -y autoremove
  # snap refresh => Currently no snap actions can be performed in chroot
}

function updateFlatpaks {
  flatpak update
}

function addRepositories {
  add-apt-repository universe
  add-apt-repository multiverse
  add-apt-repository -ys 'deb http://archive.canonical.com/ubuntu focal partner'
  # add-apt-repository -y 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main'
  # add-apt-repository -y 'https://deb.etcher.io stable etcher'
  add-apt-repository -y ppa:lutris-team/lutris
}

# add ppa repositories
updateSystem
addRepositories
apt -y update

# change snapstore to gnome software and add flathub as source
apt -y install gnome-software gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# snap remove snap-store => Currently no snap actions can be performed in chroot

# add packages

# systemtools
apt -y install git vim ssh gdebi balena-etcher-electron gnome-boxes p7zip-full
# extensions
apt -y install gnome-shell-extension-gsconnect gnome-shell-extension-gsconnect-browsers gnome-tweaks
# internet/communications
apt -y install chromium-browser evolution
flatpak install flathub com.gigitux.gtkwhats
flatpak -y install flathub org.telegram.desktop
flatpak -y install flathub org.signal.Signal
# entertainment
apt -y install wine steam-installer lutris
flatpak install flathub com.obsproject.Studio
flatpak -y install flathub com.teamspeak.TeamSpeak
flatpak install flathub com.spotify.Client

# remove packages
apt -y remove firefox thunderbird

updateSystem