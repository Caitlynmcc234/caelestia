#!/bin/bash

# Function to display an error message
error_message() {
    zenity --error --text="$1"
}

# Select executable path using zenity
exec_path=$(zenity --file-selection --title="Select the executable")

# Check if a file was selected
if [[ -z "$exec_path" || ! -f "$exec_path" ]]; then
    error_message "Invalid file path. Please provide a valid executable."
    exit 1
fi

# Select icon path using zenity
icon_path=$(zenity --file-selection --title="Select the icon (optional)" --filename="*.png" --filename="*.svg" --filename="*.xpm")

# Get the base name of the executable 
base_name=$(basename "$exec_path")

# Extract the application name (remove extension)
app_name="${base_name%.*}"

# Capitalize first letter
formatted_name="$(tr '[:lower:]' '[:upper:]' <<< ${app_name:0:1})${app_name:1}"

# Define .desktop file content
desktop_file="[Desktop Entry]
Version=1.0
Type=Application
Name=$formatted_name
Exec=$exec_path
Icon=$icon_path
Terminal=false
Categories=Utility;"

# Define the path for the .desktop file
desktop_file_path="$HOME/.local/share/applications/$app_name.desktop"

# Write the .desktop file
echo "$desktop_file" > "$desktop_file_path"

# Set executable permission
chmod +x "$desktop_file_path"

# Inform the user of success
zenity --info --text="Desktop entry created: $desktop_file_path"

