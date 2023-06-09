#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
INVERT='\033[7m'
NC='\033[0m' # No Color

print_message() {
  local color=$1
  local invert=$2
  shift 2
  local message=$@

  echo -e "${color}${invert}${message}${NC}"
}

file_to_oneline() {
  local file=$1

  IFS=$'\n'  # Set the internal field separator to newline
  array=(cat $file)  # Convert file content to array
  IFS=" "; echo "${array[*]}"  # Join array elements into a single string
}

check_arch_linux() {
    if [ "$(uname -r | cut -d '-' -f 3)" != "ARCH" ]; then
        if [ ! -f /etc/os-release ] || ! grep -q "ID=arch" /etc/os-release; then
            print_message $RED $INVERT "Error: This script is intended to run on Arch Linux only."
            exit 1
        fi
    fi
}

# Function to check if a file contains a specific pattern
file_contains_pattern() {
    local file=$1
    local pattern=$2
    if [ -f "$file" ] && grep -q "$pattern" "$file"; then
        return 0  # Pattern found
    else
        return 1  # Pattern not found
    fi
}

# Function to add text to a file if the pattern doesn't exist
add_text_if_pattern_not_found() {
    local file=$1
    local pattern=$2
    local text=$3
    if ! file_contains_pattern "$file" "$pattern"; then
        echo "$text" >> "$file"
    fi
}
