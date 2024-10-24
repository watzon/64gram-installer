#!/bin/bash

# Function to remove binaries
remove_binaries() {
  echo "Removing binaries..."
  rm -f "$BIN_DIR/Telegram"
  rm -f "$BIN_DIR/Updater"
}

# Function to remove the icon
remove_icon() {
  echo "Removing icon..."
  rm -f "$ICON_DIR/64gram.png"
}

# Function to remove the desktop file
remove_desktop_file() {
  echo "Removing desktop file..."
  rm -f "$DESKTOP_DIR/64gram.desktop"
}

# Main uninstallation function
uninstall_64gram() {
  # Variables
  BIN_DIR="$HOME/.local/bin"
  ICON_DIR="$HOME/.local/share/icons"
  DESKTOP_DIR="$HOME/.local/share/applications"

  # Execute functions
  remove_binaries
  remove_icon
  remove_desktop_file

  echo "64Gram uninstallation complete!"
}

# Run the uninstallation
uninstall_64gram