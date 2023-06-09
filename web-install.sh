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

GREEN='\033[0;32m'
NC='\033[0m' # No Color

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

print_message $GREEN "  Downloading installer..."
sudo pacman -Sy git --needed $noconfirm
git clone https://github.com/Nachtalb/os-setup /tmp/os-setup
wd=$(pwd)
cd /tmp/os-setup

# ------------------------------------------------------------------------------

print_message $GREEN "Running installer..."
./install.sh "$@"

if [[ " $* " == *" --clean "* ]]; then
    rm -rf /tmp/os-setup
fi

cd "${wd}"
print_message $GREEN "Installation completed successfully."
