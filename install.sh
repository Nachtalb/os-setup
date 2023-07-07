#!/bin/bash
set -e  # Exit immediately on error

show_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  --help       Display this help message"
    echo "  --noconfirm  Skip confirmation prompts"
    echo "  --de         Install desktop environment"
    echo "  --[stage]    Select a specific installation stage (e.g., --05)"
}

# Check if "--help" option is provided
if [[ "$*" == *--help* || "$*" == *-h* ]]; then
    show_help
    exit 0
fi

# ------------------------------------------------------------------------------

source "$(dirname $0)/utils.sh"

# ------------------------------------------------------------------------------

check_arch_linux

# ------------------------------------------------------------------------------

# Check if "--[stage]" option is provided
if [[ "$*" == --[0-9][0-9] ]]; then
  stage_option=$(echo "$*" | grep -oE -- '--[0-9]{2}' | cut -c 3-)
  stage_files=$(dirname $0)/install.d/"$stage_option"*

  file_found=0

  # Check if the stage files exist
  for file in $stage_files; do
    echo $file
    if [ -f "$file" ]; then
      file_found=1
      print_message $BLUE $INVERT "Running: '${file}'"
      source "$file" $@
    fi
  done
  
  # If no stage files were found, print an error message
  if [ "$file_found" -eq 0 ]; then
    print_message $RED "Error: Stage file '$stage_option' not found."
    exit 1
  fi
else
  # Source all files in "install.d" folder
  for file in $(dirname $0)/install.d/*.sh; do
    print_message $BLUE $INVERT "Running: '${file}'"
    source "$file" $@
  done
fi

print_message $GREEN $INVERT "Installation finished look out for orange messages for further instructions."
