
#!/usr/bin/env bash

echo "========== BACKUP TOOL =========="

read -r -p "Enter source folder path: " source

if [[ ! -d "$source" ]]; then
    echo "Error: Source folder does not exist."
    read -r -p "Press Enter to return..."
    exit 1
fi

source="$(realpath "$source")"
backup_root="$HOME/kali-toolkit/backups"
timestamp="$(date +%Y-%m-%d_%H-%M-%S)"
folder_name="$(basename "$source")"
destination="$backup_root/${folder_name}_$timestamp"

mkdir -p "$backup_root"

echo
echo "Source: $source"
echo "Backup destination: $destination"

read -r -p "Create backup? (y/N): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Backup cancelled."
    read -r -p "Press Enter to return..."
    exit 0
fi

if cp -a -- "$source" "$destination"; then
    echo "Backup completed successfully."
    echo "Saved at: $destination"
else
    echo "Backup failed. Check permissions and disk space."
fi

echo
read -r -p "Press Enter to return..."
