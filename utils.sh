#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
ORANGE='\033[0;33m'
INVERT='\033[7m'
NC='\033[0m' # No Color

print_message() {
  local color=$1
  local invert=$2
  shift 2
  local message=$@

  echo invert "${invert}"
  echo color "${color}"
  echo message "${message}"

  echo -e "${color}${invert}${message}${NC}"
}

file_to_oneline() {
  local file=$1

  IFS=$'\n'  # Set the internal field separator to newline
  array=(cat $file)  # Convert file content to array
  IFS=" "; echo "${array[*]}"  # Join array elements into a single string
}
