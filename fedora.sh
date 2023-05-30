#!/bin/bash

waitt() {
  read -t 99999 -n 1 -s -r -p "
                                                            -> Нажмите Enter для продолжения <- "

  clear
}

mirrors() {
  sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf in -y rpmfusion-free-appstream-data rpmfusion-nonfree-appstream-data
  waitt
}


dnf_tweaks(){
  sudo echo $'fastestmirror=True\nmax_parallel_downloads=10\ndefaultyes=True\nkeepcache=True' >> /etc/dnf/dnf.conf
  dnf install -y dnf-automatic
  systemctl enable dnf-automatic.timer
  waitt
}


yandex() {
  sudo rpmkeys --import https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG
  dnf config-manager --add-repo http://repo.yandex.ru/yandex-browser/rpm/stable/x86_64
  sudo dnf install -y yandex-browser-stable
  waitt
}


remove_packeges() {
  sudo dnf remove -y mediawriter rhythmbox evince yelp gnome-characters gnome-logs totem gnome-tour gnome-photos \
  gnome-maps gnome-weather gnome-font-viewer gnome-contacts gnome-clocks gnome-calendar gnome-boxes firefox libreoffice*
  waitt
}


install_packeges() {
  sudo dnf install -y discord mangohud timeshift goverlay steam lutris transmission-gtk telegram-desktop kdenlive \
  vlc gnome-tweaks htop redhat-lsb-core rocm-opencl inxi neofetch protontricks --allowerasing
  waitt
}


gstreamer() {
  sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 \
  gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
  waitt
}


lame() {
  sudo dnf install lame\* --exclude=lame-devel
  sudo dnf group upgrade --with-optional Multimedia
  waitt
}


flatpak_packeges() {
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  flatpak install -y flathub com.heroicgameslauncher.hgl com.obsproject.Studio com.mattjakeman.ExtensionManager
  waitt
}


xanmod() {
  sudo dnf copr enable -y guara/kernel-xanmod
  sudo dnf in -y kernel-xanmod-edge
  waitt
}


disable_services() {
  systemctl --user mask org.gnome.SettingsDaemon.Wacom.service
  systemctl --user mask org.gnome.SettingsDaemon.Color.service
  systemctl --user mask org.gnome.SettingsDaemon.UsbProtection.service
  systemctl --user mask org.gnome.SettingsDaemon.Smartcard.service
  waitt
}


aliases() {
  ALIAS=$'alias n="neofetch\nalias k="uname -rs"\nalias g="gnome-shell --version"\nalias f="lsb_release -sd"\nalias m="inxi -G |grep Mesa"\n \
  alias age="stat / | grep "Birth""\nalias ram="sudo dmidecode -t memory | grep Speed"\nalias cpu="lscpu | grep Model"\n \
  alias cpuc="lscpu"\nalias w="wine --version"\nalias pc="inxi -Ixxx"\nalias net="inxi -Nxxx"' \
  sudo echo $ALIAS >> ~/.bashrc
  waitt
}


gnome_extensions() {
  gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com 
  array=( 
    https://extensions.gnome.org/extension/1160/dash-to-panel/
    https://extensions.gnome.org/extension/4679/burn-my-windows/
    https://extensions.gnome.org/extension/3193/blur-my-shell/
    https://extensions.gnome.org/extension/1319/gsconnect/
    https://extensions.gnome.org/extension/5237/rounded-window-corners/
    https://extensions.gnome.org/extension/1228/arc-menu/
  )

  for i in "${array[@]}"
  do
      EXTENSION_ID=$(curl -s $i | grep -oP 'data-uuid="\K[^"]+')
      VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
      wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
      gnome-extensions install -y --force ${EXTENSION_ID}.zip
      if ! gnome-extensions list | grep --quiet ${EXTENSION_ID}; then
          busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${EXTENSION_ID}
      fi
      gnome-extensions enable ${EXTENSION_ID}
      rm ${EXTENSION_ID}.zip
  done
  waitt
}


firewall() {
  sudo firewall-cmd --zone=public --permanent --add-port=1714-1764/tcp
  sudo firewall-cmd --zone=public --permanent --add-port=1714-1764/udp
  sudo systemctl restart firewalld.service
  waitt
}


system_upgrade_clean() {
  sudo dnf upgrade -y --refresh
  sudo dnf autoremove -y
  sudo dnf clean -y all
  waitt
}


"$@"
