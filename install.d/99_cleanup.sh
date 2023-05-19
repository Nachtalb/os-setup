#!/bin/bash
source "$(dirname $0)/utils.sh"

print_message $GREEN "Running cleanup..."
print_message $GREEN "  Remove no password sudo privilege for 'archie'..."
sed -i 's/archie ALL=(ALL:ALL) NOPASSWD: ALL/archie ALL=(ALL:ALL) ALL/g' /etc/sudoers

print_message $GREEN "  Changing shell to Fish for 'archie'..."
chsh archie -s /usr/bin/fish

print_message $GREEN "  Removing 'paru' directory..."
rm -rf /home/archie/paru

print_message $RED "Setting password for 'archie'..."
if [[ " $* " == *" --noconfirm "* ]]; then
  password=$(openssl rand -base64 6 | tr -dc 'a-zA-Z0-9' | head -c8)
  echo "archie:$password" | chpasswd
  print_message $RED "  Password: $password"
  print_message $RED "  Login with the user archie and use 'passwd' to change the password."
else
  passwd archie
fi
