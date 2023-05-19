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

noconfirm=""

if [[ " $* " == *" --noconfirm "* ]]; then
    noconfirm="--noconfirm"
fi

print_message $GREEN "Starting web-install script."

print_message $GREEN "  Modifying pacman.conf..."

sed -i "s/.*ParallelDownloads.*/ParallelDownloads = 5/" /etc/pacman.conf
sed -i "s/.*Color.*/Color/" /etc/pacman.conf

print_message $GREEN "  pacman.conf modified successfully."

print_message $GREEN "  Downloading installer..."

sudo pacman -Sy git --needed $noconfirm
git clone https://github.com/Nachtalb/os-setup /tmp/os-setup
cd /tmp/os-setup

print_message $GREEN "  Installer downloaded successfully."

print_message $RED "Running installer..."

# Check if argument of the form "--[number][number]" is set
if [[ $* == *--[0-9][0-9]* ]]; then
  # Extract the number from the argument
  arg=$(echo "$*" | grep -oP -- '--\K[0-9][0-9]')
  file="install.d/${arg}_*"
  # Check if any file matches the pattern
  count=0
  for f in $file; do
    if [[ -f $f ]]; then
      print_message $GREEN "Running $f"
      bash "$f" "$@"
      count=$((count + 1))
    fi
  done
  # Display error if no matching file found
  if [[ $count -eq 0 ]]; then
    print_message $RED "No matching file found for number $arg."
  fi
else
  print_message $GREEN "Running all installation files"
  ./install.sh "$@"
fi


rm -rf /tmp/os-setup

print_message $GREEN "Installation completed successfully."
