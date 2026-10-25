
#!/usr/bin/env bash

RESET='\033[0m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'

heading() {
    printf '\n%b=== %s ===%b\n' "$CYAN" "$1" "$RESET"
}

show_command() {
    local label="$1"
    shift

    printf '%b%s:%b\n' "$GREEN" "$label" "$RESET"
    "$@" 2>&1
    echo
}

clear
heading "SYSTEM INFORMATION"

printf '%bUsername:%b %s\n' "$YELLOW" "$RESET" "$(whoami)"
printf '%bHostname:%b %s\n' "$YELLOW" "$RESET" "$(hostname)"
printf '%bCurrent directory:%b %s\n' "$YELLOW" "$RESET" "$PWD"

heading "OPERATING SYSTEM"
if [[ -r /etc/os-release ]]; then
    . /etc/os-release
    printf 'OS: %s\n' "$PRETTY_NAME"
fi

show_command "Kernel" uname -r
show_command "Uptime" uptime
show_command "Memory" free -h
show_command "Disk usage" df -h "$HOME"

heading "NETWORK INTERFACES"
if command -v ip >/dev/null 2>&1; then
    ip -brief address
else
    echo "The 'ip' command is not installed."
fi

echo
read -r -p "Press Enter to return to menu..."
