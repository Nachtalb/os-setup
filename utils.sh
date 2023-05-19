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
