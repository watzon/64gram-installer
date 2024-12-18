# 64Gram Installer

This script automates the installation of 64Gram, a Telegram desktop client. It downloads the latest release from the GitHub repository, extracts the files, installs the binaries, and sets up the necessary desktop environment files.

## Prerequisites

- **curl**: Used to fetch data from the GitHub API and download files.
- **unzip**: Required to extract the downloaded zip file.

Ensure these tools are installed on your system before running the script.

## Installation

Run the following script for a simple install:
```bash
curl -s https://raw.githubusercontent.com/watzon/64gram-installer/main/install.sh | bash
```

## Uninstallation

To uninstall, you can just run the uninstall script:
```bash
curl -s https://raw.githubusercontent.com/watzon/64gram-installer/main/uninstall.sh | bash
```


## What the Script Does

- **Checks PATH**: Verifies if `~/.local/bin` is in your PATH. If not, it offers to add it to your shell configuration file.
- **Fetches Latest Release**: Uses the GitHub API to get the latest release version of 64Gram.
- **Downloads Release**: Downloads the latest release zip file.
- **Extracts Files**: Unzips the downloaded file into a directory named `64Gram`.
- **Installs Binaries**: Moves the Telegram and Updater binaries to `~/.local/bin` and makes them executable.
- **Installs Icon**: Downloads and installs the application icon.
- **Installs Desktop File**: Downloads and installs the desktop entry file for easy access from application menus.
- **Cleans Up**: Removes temporary files created during the installation process.

## Post-Installation

After installation, you can run 64Gram from your application menu or by executing the `Telegram` binary located in `~/.local/bin`.

## Troubleshooting

- If `~/.local/bin` is not in your PATH, the script will prompt you to add it. Follow the instructions provided by the script to update your PATH.
- Ensure you have the necessary permissions to execute the script and write to the installation directories.

## License

This script is provided under the MIT License. See the LICENSE file for more details.

