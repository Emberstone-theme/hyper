#!/bin/bash

# Variables
THEME_NAME="emberstone"
THEME_DIR="$HOME/.hyper_plugins/local/$THEME_NAME"
HYPER_CONFIG="$HOME/.hyper.js"
BACKUP_CONFIG="$HOME/.hyper.js.bak"
REPO_URL="https://github.com/Emberstone-theme/hyper"
ZIP_URL="$REPO_URL/archive/refs/heads/main.zip"
TEMP_DIR="/tmp/${THEME_NAME}_theme"

# Function to download and unzip the theme
download_theme() {
    echo "Downloading the latest version of the $THEME_NAME theme..."
    mkdir -p "$TEMP_DIR"
    wget -O "$TEMP_DIR/theme.zip" "$ZIP_URL"
    echo "Unzipping the theme..."
    unzip -q "$TEMP_DIR/theme.zip" -d "$TEMP_DIR"
    echo "Download and unzip completed."
}

# Function to update the theme
update_theme() {
    echo "Updating the $THEME_NAME theme..."
    rm -rf "$THEME_DIR"
    mkdir -p "$THEME_DIR"
    cp -R "$TEMP_DIR/hyper-main/"* "$THEME_DIR/"
    echo "The theme $THEME_NAME has been updated."
}

# 1. Download the latest version of the theme
download_theme

# 2. Check if the theme already exists
if [ -d "$THEME_DIR" ]; then
    echo "The $THEME_NAME theme already exists in $THEME_DIR."
    read -p "Do you want to update it? (y/n): " response
    if [ "$response" == "y" ]; then
        update_theme
    else
        echo "Theme update canceled."
        rm -rf "$TEMP_DIR"
        exit 0
    fi
else
    # If the theme does not exist, install it
    echo "Installing the $THEME_NAME theme..."
    mkdir -p "$THEME_DIR"
    cp -R "$TEMP_DIR/hyper-main/"* "$THEME_DIR/"
    echo "The $THEME_NAME theme has been installed."
fi

# 3. Backup the current .hyper.js configuration file
echo "Backing up the current Hyper configuration to $BACKUP_CONFIG..."
cp "$HYPER_CONFIG" "$BACKUP_CONFIG"

# 4. Update the .hyper.js file to use the Emberstone theme
echo "Updating the Hyper configuration to use the $THEME_NAME theme..."
if grep -q "localPlugins:" "$HYPER_CONFIG"; then
    # If the localPlugins array exists, add the theme to it
    sed -i "/localPlugins:/,/],/ s/]$/, '$THEME_NAME']/g" "$HYPER_CONFIG"
else
    # If the localPlugins array does not exist, add it and include the theme
    sed -i "/module.exports = {/a \  localPlugins: ['$THEME_NAME']," "$HYPER_CONFIG"
fi

echo "The Hyper configuration has been updated to use the $THEME_NAME theme."
echo "Please restart Hyper to apply the new theme."

# 5. Clean up temporary files
echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "Installation process completed."
