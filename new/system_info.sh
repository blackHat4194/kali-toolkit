#!/usr/bin/env bash
BASE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"; source "$BASE_DIR/config.sh"
clear 2>/dev/null || true; heading 'SYSTEM INFORMATION'
printf 'Username: %s\nHostname: %s\nToolkit path: %s\n' "$(id -un)" "$(hostname 2>/dev/null || echo unknown)" "$TOOLKIT_DIR"
if [[ -r /etc/os-release ]]; then . /etc/os-release; printf 'OS: %s\n' "${PRETTY_NAME:-unknown}"; fi
run_optional(){ local label="$1" cmd="$2"; shift 2; heading "$label"; if have_cmd "$cmd"; then "$cmd" "$@" 2>&1 || warning "$label command returned an error."; else warning "Command unavailable: $cmd"; fi; }
run_optional Kernel uname -r; run_optional Uptime uptime; run_optional Memory free -h; run_optional 'Disk usage' df -h "$HOME"; run_optional 'Network interfaces' ip -brief address; pause_screen
