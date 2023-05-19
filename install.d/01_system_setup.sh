#!/bin/bash
source "$(dirname $0)/utils.sh"

noconfirm=""

if [[ " $* " == *" --noconfirm "* ]]; then
    noconfirm="--noconfirm"
fi

# Update system and install dependencies
print_message $GREEN "Setting up system"
print_message $GREEN "  Updating system..."
sudo pacman -Syu $noconfirm
print_message $GREEN "  Installing system dependencies..."
sudo pacman -Sy rustup base-devel fakeroot expac fzf pacman-contrib --needed $noconfirm
print_message $GREEN "  Setting Rust default version..."
rustup default stable
su archie -c "rustup default stable"

if ! command -v paru >/dev/null 2>&1; then
  print_message $GREEN "  Cloning 'paru' repository..."
  su archie -c "git clone https://aur.archlinux.org/paru.git /home/archie/paru"
  print_message $GREEN "  Building and installing 'paru'..."
  su archie -c "cd /home/archie/paru && makepkg -si --needed $noconfirm"
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
