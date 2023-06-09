#!/bin/bash

# Color variables
GREEN='\033[0;32m'
RED='\033[0;31m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

# Function to print colored echo statements
print_message() {
  local color=$1
  shift
  echo -e "${color}$@${NC}"
}

file_to_oneline() {
  local file=$1

  IFS=$'\n'  # Set the internal field separator to newline
  array=(cat $file)  # Convert file content to array
  IFS=" "; echo "${array[*]}"  # Join array elements into a single string
}
