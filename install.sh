#!/bin/bash
set -e  # Exit immediately on error

for file in $(dirname $0)/install.d/*.sh; do
    source $file $1
done
