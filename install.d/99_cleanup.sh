#!/bin/bash
source "$(dirname $0)/utils.sh"

print_message $GREEN "Running cleanup..."
print_message $GREEN "  Remove no password sudo privilege for 'archie'..."
sed -i 's/archie ALL=(ALL:ALL) NOPASSWD: ALL/archie ALL=(ALL:ALL) ALL/g' /etc/sudoers

print_message $GREEN "  Changing shell to Fish for 'archie'..."
chsh root -s /usr/bin/fish
chsh archie -s /usr/bin/fish

print_message $GREEN "  Removing 'paru' directory..."
rm -rf /home/archie/paru

if [[ "$(uname -r)" == *icrosoft* ]]; then
  print_message $GREEN "  Setting archie as default WSL user"
  if ! grep -q "archie" /etc/wsl.conf; then
    # If not, append the user configuration
    echo "[user]" >> /etc/wsl.conf
    echo "default=archie" >> /etc/wsl.conf
  fi
fi

print_message $ORANGE "Setting password for 'archie'..."
if [[ " $* " == *" --noconfirm "* ]]; then
  password=$(openssl rand -base64 6 | tr -dc 'a-zA-Z0-9' | head -c8)
  echo "archie:$password" | chpasswd
  print_message $ORANGE "  Password: $password"
  print_message $ORANGE "  Login with the user archie and use 'passwd' to change the password."
else
  passwd archie
fi
