#!/bin/bash

# Function to get the latest release version from GitHub
get_latest_release() {
  curl --silent "https://api.github.com/repos/TDesktop-x64/tdesktop/releases/latest" | # Get latest release from GitHub API
  grep '"tag_name":' |                                                                # Get tag line
  sed -E 's/.*"([^"]+)".*/\1/'                                                        # Extract version number
}

# Function to download the latest release
download_release() {
  echo "Downloading 64Gram version $VERSION..."
  curl -L -o "$ZIP_FILE" "$DOWNLOAD_URL"
}

# Function to extract the downloaded zip file
extract_files() {
  echo "Extracting files..."
  unzip "$ZIP_FILE" -d 64Gram
}

# Function to install binaries
install_binaries() {
  echo "Installing binaries..."
  mkdir -p "$BIN_DIR"
  mv 64Gram/Telegram "$BIN_DIR"
  mv 64Gram/Updater "$BIN_DIR"
  chmod +x "$BIN_DIR/Telegram"
  chmod +x "$BIN_DIR/Updater"
}

# Function to install the icon
install_icon() {
  echo "Installing icon..."
  mkdir -p "$ICON_DIR"
  curl -L -o "$ICON_DIR/64gram.png" "$INSTALLER_REPO/64gram.png"
  chmod 555 "$ICON_DIR/64gram.png"
}

# Function to install the desktop file
install_desktop_file() {
  echo "Installing desktop file..."
  mkdir -p "$DESKTOP_DIR"
  curl -L "$INSTALLER_REPO/64gram.desktop" | sed "s/\$USER/$USER/g" > "$DESKTOP_DIR/64gram.desktop"
}

# Function to clean up temporary files
cleanup() {
  echo "Cleaning up..."
  rm -rf 64Gram
  rm "$ZIP_FILE"
}

# Function to check if ~/.local/bin is on PATH
check_path() {
  if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo "~/.local/bin is not on your PATH."
    read -p "Do you want to add it to your shell configuration file? (y/n) " choice
    if [[ "$choice" == "y" ]]; then
      if [[ -n "$BASH_VERSION" ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
        echo "Added to .bashrc. Please run 'source ~/.bashrc' or restart your terminal."
      elif [[ -n "$ZSH_VERSION" ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
        echo "Added to .zshrc. Please run 'source ~/.zshrc' or restart your terminal."
      else
        echo "Unsupported shell. Please add 'export PATH=\"$HOME/.local/bin:\$PATH\"' to your shell configuration file manually."
      fi
    else
      echo "Skipping PATH update."
    fi
  fi
}

# Main installation function
install_64gram() {
  # Variables
  REPO_URL="https://github.com/TDesktop-x64/tdesktop"
  INSTALLER_REPO="https://raw.githubusercontent.com/watzon/64gram-installer/main/assets"
  BIN_DIR="$HOME/.local/bin"
  ICON_DIR="$HOME/.local/share/icons"
  DESKTOP_DIR="$HOME/.local/share/applications"

  # Check if ~/.local/bin is on PATH
  check_path

  # Get the latest release version
  VERSION=$(get_latest_release)
  ZIP_FILE="64Gram_${VERSION#v}_linux.zip"
  DOWNLOAD_URL="$REPO_URL/releases/download/$VERSION/$ZIP_FILE"

  # Execute functions
  download_release
  extract_files
  install_binaries
  install_icon
  install_desktop_file
  cleanup

  echo "64Gram installation complete!"
}

# Run the installation
install_64gram
