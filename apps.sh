#!/bin/bash

# Define colors for visual feedback
GREEN="\033[1;32m"
BLUE="\033[1;34m"
RED="\033[1;31m"
RESET="\033[0m"

# Helper function to display progress
function print_status {
    echo -e "${BLUE}=> ${1}${RESET}"
}

function print_success {
    echo -e "${GREEN}✔ ${1} installed successfully!${RESET}"
}

function print_error {
    echo -e "${RED}✖ Error installing ${1}${RESET}"
}

# Update system
print_status "Updating package lists..."
sudo apt update && sudo apt upgrade -y
print_success "System updated"

# Install nvim
print_status "Installing Neovim..."
if sudo apt install -y nvim; then
    print_success "Neovim"
else
    print_error "Neovim"
fi

# Install Ranger
print_status "Installing Ranger..."
if sudo apt install -y ranger; then
    print_success "Ranger"
else
    print_error "Ranger"
fi

# Install Git
print_status "Installing Git..."
if sudo apt install -y git; then
    print_success "Git"
else
    print_error "Git"
fi

# Clone NvChad
print_status "Cloning NvChad..."
if git clone https://github.com/NvChad/starter ~/.config/nvim && nvim; then
    print_success "NvChad starter"
else
    print_error "NvChad starter"
fi

# Install Docker
print_status "Installing Docker..."
if sudo apt install -y docker.io && sudo systemctl enable --now docker; then
    sudo usermod -aG docker $USER
    print_success "Docker"
else
    print_error "Docker"
fi

# Install Snap
print_status "Installing Snapd..."
if sudo apt install -y snapd; then
    print_success "Snap"
else
    print_error "Snap"
fi

# Install Flutter
print_status "Installing Flutter..."
if sudo snap install flutter --classic; then
    print_success "Flutter"
else
    print_error "Flutter"
fi

# Install Nerd Fonts (Optional step)
print_status "Installing Nerd Fonts..."
if sudo apt install -y fonts-firacode; then
    print_success "Nerd Fonts (Fira Code)"
    echo -e "${GREEN}DO INSTALL NERD FONTS FOR A BETTER EXPERIENCE${RESET}"
else
    print_error "Nerd Fonts"
fi

# Final message
echo -e "${GREEN}All requested software has been installed!${RESET}"
echo -e "${BLUE}Please restart your terminal for changes to take effect.${RESET}"

# Optionally reboot
read -p "Do you want to reboot now? (y/n): " answer
if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    sudo reboot
else
    echo -e "${GREEN}You can reboot later manually to apply changes.${RESET}"
fi
