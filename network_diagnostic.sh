
#!/usr/bin/env bash

RESET='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'

heading() {
    printf '\n%b=== %s ===%b\n' "$CYAN" "$1" "$RESET"
}

pause_screen() {
    echo
    read -r -p "Press Enter to continue..."
}

while true; do
    clear
    heading "NETWORK DIAGNOSTICS"

    echo "1. Show IP addresses"
    echo "2. Show routing table"
    echo "3. Check DNS resolution"
    echo "4. Test connectivity"
    echo "5. Show listening sockets"
    echo "6. Return to main menu"
    echo

    read -r -p "Choose an option: " choice

    case "$choice" in
        1)
            heading "IP ADDRESSES"
            ip -brief address
            pause_screen
            ;;

        2)
            heading "ROUTING TABLE"
            ip route
            pause_screen
            ;;

        3)
            read -r -p "Enter a hostname (e.g. example.com): " host

            if [[ "$host" =~ ^[a-zA-Z0-9.-]+$ ]] &&
               [[ "$host" == *[a-zA-Z0-9]* ]]; then
                heading "DNS LOOKUP"

                if getent ahosts "$host"; then
                    printf '%bDNS lookup completed.%b\n' "$GREEN" "$RESET"
                else
                    printf '%bDNS lookup failed.%b\n' "$RED" "$RESET"
                fi
            else
                printf '%bInvalid hostname.%b\n' "$RED" "$RESET"
            fi

            pause_screen
            ;;

        4)
            read -r -p "Enter hostname to test (e.g. example.com): " host

            if [[ "$host" =~ ^[a-zA-Z0-9.-]+$ ]] &&
               [[ "$host" == *[a-zA-Z0-9]* ]]; then
                heading "CONNECTIVITY TEST"

                if ping -c 4 -W 2 "$host"; then
                    printf '%bHost responded to ping.%b\n' "$GREEN" "$RESET"
                else
                    printf '%bPing failed or was blocked.%b\n' "$YELLOW" "$RESET"
                fi
            else
                printf '%bInvalid hostname.%b\n' "$RED" "$RESET"
            fi

            pause_screen
            ;;

        5)
            heading "LISTENING SOCKETS"
            ss -tuln
            pause_screen
            ;;

        6)
            break
            ;;

        *)
            printf '%bInvalid option.%b\n' "$RED" "$RESET"
            sleep 1
            ;;
    esac
done
