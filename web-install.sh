#!/bin/bash

set -e  # Exit immediately on error

# Color variables
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to print colored echo statements
print_message() {
    local color=$1
    shift
    echo -e "${color}$@${NC}"
}

print_message $GREEN "Starting web-install script."

print_message $GREEN "  Modifying pacman.conf..."

sed -i "s/.*ParallelDownloads.*/ParallelDownloads = 5/" /etc/pacman.conf
sed -i "s/.*Color.*/Color/" /etc/pacman.conf

print_message $GREEN "  pacman.conf modified successfully."

print_message $GREEN "  Downloading installer..."

sudo pacman -Sy git --needed --noconfirm
git clone https://github.com/Nachtalb/os-setup /tmp/new-install
cd /tmp/new-install

print_message $GREEN "  Installer downloaded successfully."

print_message $RED "Running installer..."

./install.sh

print_message $GREEN "Installation completed successfully."
