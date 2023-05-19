#!/bin/bash
source "$(dirname $0)/utils.sh"

print_message $GREEN "Installing system dependencies..."
read -p "Do you want to install GUI dependencies? (y/n): " install_gui

print_message $GREEN "  User input received: $install_gui"

# Declare variables
default_file="$(dirname $0)/data/arch-deps.txt"
gui_file="$(dirname $0)/data/arch-deps-gui.txt"

print_message $GREEN "  Loading file content based on user input..."

# Check user's input and load file content accordingly
if [ "$install_gui" = "y" ] || [ "$install_gui" = "Y" ]; then
    file_content=$(cat "$default_file" "$gui_file")
else
    file_content=$(cat "$default_file")
fi

print_message $GREEN "  Installing dependencies using 'paru'..."
IFS=$'\n'  # Set the internal field separator to newline
deps_array=($file_content)  # Convert file content to array
deps_args=$(IFS=" "; echo "${deps_array[*]}")  # Join array elements into a single string

su archie -c "paru -Sy $deps_args --needed --noconfirm"
