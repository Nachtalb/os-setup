#!/bin/bash
source "$(dirname $0)/utils.sh"

noconfirm=""

if [[ " $* " == *" --noconfirm "* ]]; then
    noconfirm="--noconfirm"
fi

# Update system and install dependencies
print_message $GREEN "Setting up system"
print_message $GREEN "  Configuring pacman"

sed -i "s/.*ParallelDownloads.*/ParallelDownloads = 10/" /etc/pacman.conf
sed -i "s/.*Color.*/Color/" /etc/pacman.conf

print_message $GREEN "  Updating system..."
pacman-key --init
pacman-key --populate
sudo pacman -Sy archlinux-keyring $noconfirm --needed
sudo pacman -Syu $noconfirm

print_message $GREEN "  Installing system dependencies..."
if ! fakeroot -v paru >/dev/null 2>&1; then
  sudo pacman -Sy fakeroot-tcp --needed $noconfirm
fi
sudo pacman -Sy rustup base-devel wget expac fzf pacman-contrib --needed $noconfirm

print_message $GREEN "  Setting Rust default version..."
rustup default stable
su archie -c "rustup default stable"

if ! command -v paru >/dev/null 2>&1; then
  target_dir="/home/archie/paru"
  print_message $GREEN "  Cloning 'paru' repository..."
  if [ ! -d "${target_dir}" ]; then
    su archie -c "git clone https://aur.archlinux.org/paru.git ${target_dir}"
  else
    su archie -c "cd ${target_dir} && git pull -r"
  fi
  print_message $GREEN "  Building and installing 'paru'..."
  su archie -c "cd ${target_dir} && makepkg -si --needed $noconfirm"
else
  print_message $GREEN "  'paru' is already installed."
fi

if ! command -v pacui >/dev/null 2>&1; then
  print_message $GREEN " Installing 'pacui'..."
  wget "https://raw.githubusercontent.com/excalibur1234/pacui/master/pacui"
  chmod +x pacui
  sudo mv pacui /usr/bin/
else
  print_message $GREEN " 'pacui' is already installed"
fi
