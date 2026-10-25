#!/usr/bin/env bash
set -u
BASE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
source "$BASE_DIR/config.sh"
ensure_project_dirs
while true; do
 clear 2>/dev/null || true; heading 'PORTABLE LINUX TOOLKIT'; printf 'Project: %s\n\n' "$TOOLKIT_DIR"
 printf '1. File & Directory Explorer\n2. File Organizer\n3. Backup & Restore\n4. System Information\n5. Network Diagnostics\n6. Git Repository Workspace\n7. Exit\n\n'
 read -r -p 'Select an option: ' choice || break
 case "$choice" in 1) script=explorer.sh;; 2) script=file_organizer.sh;; 3) script=backup.sh;; 4) script=system_info.sh;; 5) script=network_diagnostic.sh;; 6) script=workspace.sh;; 7) success 'Exiting toolkit.'; break;; *) error 'Invalid option.'; sleep 1; continue;; esac
 if [[ -f "$BASE_DIR/$script" ]]; then bash "$BASE_DIR/$script"; else error "Module not found: $script"; pause_screen; fi
done
