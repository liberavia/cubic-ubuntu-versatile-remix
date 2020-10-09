#!/usr/bin/env sh

function updateSystem {
  apt -y update
  apt -y dist-upgrade
  apt -y autoremove
  # snap refresh => Currently no snap actions can be performed in chroot
}

function updateFlatpaks {
  flatpak -y update
}

function addRepositories {
  add-apt-repository universe
  add-apt-repository multiverse
  add-apt-repository -ys 'deb http://archive.canonical.com/ubuntu focal partner'
  add-apt-repository -y ppa:lutris-team/lutris
}

function installGoogleChrome {
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  dpkg -i google-chrome-stable_current_amd64.deb
  apt-get install -yf
  rm google-chrome-stable_current_amd64.deb
}

downloadBackground {
  wget https://raw.githubusercontent.com/liberavia/cubic-ubuntu-versatile-remix/main/assets/wallpaper/final-ubuntu-versatile-remix.png
  mv final-ubuntu-versatile-remix.png /usr/share/backgrounds/final-ubuntu-versatile-remix.png
}

function setVersatileGnomeDefaults {
cat > /usr/share/glib-2.0/schemas/90_ubuntu-versatile-favorites.gschema.override << ENDOFFILE
[org.gnome.shell]
favorite-apps = ['org.gnome.Nautilus.desktop', 'google-chrome.desktop', 'org.gnome.Evolution.desktop', 'gnome-control-center.desktop', 'org.gnome.Software.desktop', 'yelp.desktop']

[org.gnome.desktop.background]
picture-uri = 'file:///usr/share/backgrounds/final-ubuntu-versatile-remix.png'

[org.gnome.desktop.screensaver]
picture-uri = 'file:///usr/share/backgrounds/final-ubuntu-versatile-remix.png'
ENDOFFILE
glib-compile-schemas /usr/share/glib-2.0/schemas/
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
apt -y install git vim ssh gdebi gnome-boxes p7zip-full
# extensions
apt -y install gnome-shell-extension-gsconnect gnome-shell-extension-gsconnect-browsers gnome-tweaks
# internet/communications
installGoogleChrome
flatpak -y install flathub org.gnome.Evolution
flatpak -y install flathub com.gigitux.gtkwhats
flatpak -y install flathub org.telegram.desktop
flatpak -y install flathub org.signal.Signal
# entertainment
apt -y install wine steam-installer lutris
flatpak -y install flathub com.obsproject.Studio
flatpak -y install flathub com.teamspeak.TeamSpeak
flatpak -y install flathub com.discordapp.Discord
flatpak -y install flathub com.spotify.Client

# remove packages
apt -y remove firefox thunderbird

#finish
downloadBackground
setVersatileGnomeDefaults
updateSystem
updateFlatpaks