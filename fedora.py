import subprocess
import os 

os.system('clear')
script_path = "~/fedora-tweaks/fedora.sh"


def mirrors():
  subprocess.call(["bash", script_path, "mirrors"])

def dnf_tweaks():
  subprocess.call(["bash", script_path, "dnf_tweaks"])

def yandex():
  subprocess.call(["bash", script_path, "yandex"])

def remove_packeges():
  subprocess.call(["bash", script_path, "remove_packeges"])

def install_packeges():
  subprocess.call(["bash", script_path, "install_packeges"])

def gstreamer():
  subprocess.call(["bash", script_path, "gstreamer"])

def lame():
  subprocess.call(["bash", script_path, "lame"])

def flatpak_packeges():
  subprocess.call(["bash", script_path, "flatpak_packeges"])

def xanmod():
  subprocess.call(["bash", script_path, "xanmod"])

def disable_services():
  subprocess.call(["bash", script_path, "disable_services"])

def aliases():
  subprocess.call(["bash", script_path, "aliases"])

def gnome_extensions():
  subprocess.call(["bash", script_path, "gnome_extensions"])

def firewall():
  subprocess.call(["bash", script_path, "firewall"])

def system_upgrade_clean():
  subprocess.call(["bash", script_path, "system_upgrade_clean"])

def all_tweaks():
  mirrors(), dnf_tweaks(), yandex(), remove_packeges(), install_packeges(), gstreamer(), lame(), xanmod(), disable_services(), aliases(), gnome_extensions(), firewall(), system_upgrade_clean()


while True:
  a = int(input('''
  1 - Добавление зеркал   2 - DNF tweaks   3 - Установка Yandex Browser
  4 - Удаление ненужных пакетов   5 - Установка пакетов   6 - Установка openh264
  7 - Установка lame   8 - Устанвока flatpak пакетов   9 - Установка xanmod
  10 - Отключение ненужных служб   11 - Добавление алиасов   12 - Загрузка расширений для Gnome
  13 - Настройка firewall   14 - Очистка DNF
  15 - Выполнить все пункты
  16 - Завершить скрипт


  Выберите действие: '''))

  match a:
    case 1:
      mirrors()
    case 2:
      dnf_tweaks()
    case 3:
      yandex()
    case 4:
      remove_packeges()
    case 5:
      install_packeges()
    case 6:
      gstreamer()
    case 7:
      lame()
    case 8:
      flatpak_packeges()
    case 9:
      xanmod()
    case 10:
      disable_services()
    case 11:
      aliases()
    case 12:
      gnome_extensions()
    case 13:
      firewall()
    case 14:
      system_upgrade_clean()
    case 15:
      all_tweaks()
    case 16:
      break
    case _:
      print("Ошибка!")
      subprocess.call(["bash", script_path, "waitt"])
