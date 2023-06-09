#!/bin/bash

set -e  # Exit immediately on error

show_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  --help       Display this help message"
    echo "  --noconfirm  Skip confirmation prompts"
    echo "  --de         Install desktop environment"
    echo "  --[stage]    Select a specific installation stage (e.g., --05)"
    echo "  --clean      Clean up installation when done"
}

# Check if "--help" option is provided
if [[ "$*" == *--help* || "$*" == *-h* ]]; then
    show_help
    exit 0
fi

# ------------------------------------------------------------------------------

source <(curl -sSL "https://raw.githubusercontent.com/Nachtalb/os-setup/master/utils.sh?token=$(date +%s)")

# ------------------------------------------------------------------------------

check_arch_linux

# ------------------------------------------------------------------------------

noconfirm=""

if [[ " $* " == *" --noconfirm "* ]]; then
    noconfirm="--noconfirm"
fi

print_message $GREEN $INVERT "Starting web-install script."

print_message $GREEN "  Downloading installer..."
sudo pacman -Sy git --needed $noconfirm
target_dir="/tmp/os-setup"
if [ -d "${target_dir}" ]; then
  print_message $BLUE "  OS-Setup was already downloaded to '${target_dir}'"
  cd $target_dir
  git pull -r
else
  git clone https://github.com/Nachtalb/os-setup "${target_dir}"
fi

cd /tmp/os-setup

# ------------------------------------------------------------------------------

print_message $GREEN "Running installer..."
./install.sh "$@"

if [[ " $* " == *" --clean "* ]]; then
    rm -rf /tmp/os-setup
fi

print_message $GREEN $INVERT "Installation completed successfully."
