#!/usr/bin/env bash
BASE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"; source "$BASE_DIR/config.sh"
while true; do
 clear 2>/dev/null || true; heading 'BASIC NETWORK DIAGNOSTICS'; printf '1. IP addresses\n2. Routing table\n3. DNS lookup\n4. Ping test\n5. Listening sockets\n6. Return\n\n'; read -r -p 'Choose: ' c || break
 case "$c" in
 1) if have_cmd ip; then ip -brief address; else warning "'ip' unavailable."; fi; pause_screen;;
 2) if have_cmd ip; then ip route; else warning "'ip' unavailable."; fi; pause_screen;;
 3) read -r -p 'Hostname: ' h; if [[ "$h" =~ ^[a-zA-Z0-9][a-zA-Z0-9.-]*[a-zA-Z0-9]$ || "$h" =~ ^[a-zA-Z0-9]$ ]]; then if have_cmd getent; then getent ahosts "$h" || warning 'DNS lookup failed.'; else warning "'getent' unavailable."; fi; else error 'Invalid hostname.'; fi; pause_screen;;
 4) read -r -p 'Hostname/IP: ' h; if [[ "$h" =~ ^[a-zA-Z0-9][a-zA-Z0-9.-]*[a-zA-Z0-9]$ || "$h" =~ ^[a-zA-Z0-9]$ || "$h" =~ ^[0-9a-fA-F:.]+$ ]]; then if have_cmd ping; then ping -c 4 -W 2 "$h" || warning 'Ping failed or is blocked.'; else warning "'ping' unavailable."; fi; else error 'Invalid host.'; fi; pause_screen;;
 5) if have_cmd ss; then ss -tuln; else warning "'ss' unavailable."; fi; pause_screen;; 6) break;; *) error 'Invalid option.'; sleep 1;; esac
done
