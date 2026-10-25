
#!/usr/bin/env bash

BASE_DIR="$HOME/kali-toolkit"

RESET='\033[0m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'

while true; do
    clear

    printf '%b' "$CYAN"
    echo "╔══════════════════════════════════════╗"
    echo "║             KALI TOOLKIT             ║"
    echo "╚══════════════════════════════════════╝"
    printf '%b' "$RESET"

    echo "1. File & Directory Explorer"
    echo "2. File Organizer"
    echo "3. Backup Tool"
    echo "4. System Information"
    echo "5. Network Diagnostics"
    echo "6. GitHub Learning Workspace"
    echo "7. Exit"
    echo

    read -r -p "Select an option: " choice

    case "$choice" in
        1) script="explorer.sh" ;;
        2) script="file_organizer.sh" ;;
        3) script="backup.sh" ;;
        4) script="system_info.sh" ;;
        5) script="network_diagnostic.sh" ;;
        6) script="workspace.sh" ;;
        7)
            echo "Exiting Kali Toolkit..."
            break
            ;;
        *)
            printf '%bInvalid option.%b\n' "$RED" "$RESET"
            sleep 1
            continue
            ;;
    esac

    if [[ -f "$BASE_DIR/$script" ]]; then
        bash "$BASE_DIR/$script"
    else
        printf '%bModule not created yet: %s%b\n' "$RED" "$script" "$RESET"
        read -r -p "Press Enter to return..."
    fi
done
