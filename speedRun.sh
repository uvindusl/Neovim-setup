#!/bin/bash

cat << EOF
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗    ███████╗██████╗ ███████╗███████╗██████╗     ██████╗ ██╗   ██╗███╗   ██╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║    ██╔════╝██╔══██╗██╔════╝██╔════╝██╔══██╗    ██╔══██╗██║   ██║████╗  ██║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║    ███████╗██████╔╝█████╗  █████╗  ██║  ██║    ██████╔╝██║   ██║██╔██╗ ██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║    ╚════██║██╔═══╝ ██╔══╝  ██╔══╝  ██║  ██║    ██╔══██╗██║   ██║██║╚██╗██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║    ███████║██║     ███████╗███████╗██████╔╝    ██║  ██║╚██████╔╝██║ ╚████║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝    ╚══════╝╚═╝     ╚══════╝╚══════╝╚═════╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
EOF                                                                                                                             

set -e

echo "Installing Neovim..."
sudo apt update
sudo apt install -y neovim

echo "Installing Dependencies for Neovim Setup..."
sudo apt install -y make gcc ripgrep unzip git xclip


NVIM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

if [ -d "$NVIM_DIR" ]; then
    echo "Warning: $NVIM_DIR already exists!"
    read -p "Do you want to backup and replace it? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mv "$NVIM_DIR" "${NVIM_DIR}.backup.$(date +%s)"
        echo "Backed up existing config"
    else
        echo "Installation cancelled"
        exit 1
    fi
fi

echo "Creating config directory for Neovim..."
mkdir -p "$NVIM_DIR"

echo "Cloning config files..."
git clone https://github.com/uvindusl/Neovim-setup.git "$NVIM_DIR"

echo "Neovim Setup Complete!"
echo "Starting Neovim and installing packages..."
nvim
