
#!/usr/bin/env bash

# Main menu for Kali Toolkit

clear

while true; do
    echo "================================"
    echo "        KALI TOOLKIT"
    echo "================================"
    echo "1. File Organizer"
    echo "2. Automatic Backup Tool"
    echo "3. System Information"
    echo "4. Exit"
    echo "================================"

    read -r -p "Select an option: " choice

    case "$choice" in
        1)
            bash "$HOME/kali-toolkit/file_organizer.sh"
            ;;
        2)
            bash "$HOME/kali-toolkit/backup.sh"
            ;;
        3)
            echo
            echo "Username: $(whoami)"
            echo "Hostname: $(hostname)"
            echo "Current directory: $(pwd)"
            echo
            read -r -p "Press Enter to continue..."
            ;;
        4)
            echo "Exiting Kali Toolkit..."
            break
            ;;
        *)
            echo "Invalid option. Please choose 1-4."
            sleep 2
            ;;
    esac

    clear
done
