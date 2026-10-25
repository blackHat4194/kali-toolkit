#!/usr/bin/env bash
set -u
BASE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"; source "$BASE_DIR/config.sh"
current_dir="${EXPLORER_START_DIR:-$PWD}"
valid_name(){ [[ -n "$1" && "$1" != . && "$1" != .. && "$1" != */* ]]; }
change_directory(){ local target="$1" resolved; [[ "$target" = /* ]] && resolved="$target" || resolved="$current_dir/$target"; if [[ -d "$resolved" ]]; then current_dir="$(cd -- "$resolved" && pwd -P)"; success "Current directory: $current_dir"; else error "Directory does not exist: $target"; return 1; fi; }
while true; do
 clear 2>/dev/null || true; heading 'FILE & DIRECTORY EXPLORER'; printf 'Current directory: %s\n\n' "$current_dir"
 printf '1. List items\n2. Item details\n3. Create file\n4. Create directory\n5. Read text file\n6. Edit file (nano)\n7. Rename item\n8. Copy file\n9. Delete file or empty directory\n10. Enter child directory\n11. Parent directory\n12. Jump to path\n13. Search names\n14. Show path\n15. Exit\n\n'
 read -r -p 'Choose: ' choice || break
 case "$choice" in
 1) ls -lah --color=auto -- "$current_dir" 2>/dev/null || ls -lah -- "$current_dir"; pause_screen;;
 2) read -r -p 'Item name: ' n; if valid_name "$n" && [[ -e "$current_dir/$n" || -L "$current_dir/$n" ]]; then ls -ldh -- "$current_dir/$n"; else error 'Item not found or invalid name.'; fi; pause_screen;;
 3) read -r -p 'New file name: ' n; if valid_name "$n" && [[ ! -e "$current_dir/$n" && ! -L "$current_dir/$n" ]] && touch -- "$current_dir/$n"; then success 'File created.'; else error 'Invalid name, existing item, or create failed.'; fi; pause_screen;;
 4) read -r -p 'New directory name: ' n; if valid_name "$n" && mkdir -- "$current_dir/$n"; then success 'Directory created.'; else error 'Invalid name or create failed.'; fi; pause_screen;;
 5) read -r -p 'Text file name: ' n; if valid_name "$n" && [[ -f "$current_dir/$n" ]]; then if have_cmd less; then less -- "$current_dir/$n"; else cat -- "$current_dir/$n"; fi; else error 'File not found.'; fi; pause_screen;;
 6) read -r -p 'Text file name: ' n; if ! valid_name "$n"; then error 'Use a filename, not a path.'; elif ! have_cmd nano; then error 'nano is not installed.'; elif [[ -d "$current_dir/$n" ]]; then error 'That is a directory.'; else nano -- "$current_dir/$n"; fi; pause_screen;;
 7) read -r -p 'Existing item: ' a; read -r -p 'New name: ' b; if valid_name "$a" && valid_name "$b" && [[ -e "$current_dir/$a" || -L "$current_dir/$a" ]] && [[ ! -e "$current_dir/$b" && ! -L "$current_dir/$b" ]] && mv -- "$current_dir/$a" "$current_dir/$b"; then success 'Renamed.'; else error 'Rename failed; check names and destination.'; fi; pause_screen;;
 8) read -r -p 'Source file: ' a; read -r -p 'Destination filename: ' b; if valid_name "$a" && valid_name "$b" && [[ -f "$current_dir/$a" && ! -e "$current_dir/$b" ]] && cp -p -- "$current_dir/$a" "$current_dir/$b"; then success 'Copied.'; else error 'Copy failed; check names and destination.'; fi; pause_screen;;
 9) read -r -p 'Item name: ' n; if ! valid_name "$n" || [[ ! -e "$current_dir/$n" && ! -L "$current_dir/$n" ]]; then error 'Item not found.'; else warning "Permanent deletion: $current_dir/$n"; read -r -p 'Type DELETE to confirm: ' ok; if [[ "$ok" == DELETE ]]; then if [[ -d "$current_dir/$n" && ! -L "$current_dir/$n" ]]; then rmdir -- "$current_dir/$n" && success 'Empty directory deleted.' || error 'Directory is not empty or delete failed.'; else rm -- "$current_dir/$n" && success 'Deleted.' || error 'Delete failed.'; fi; else info 'Cancelled.'; fi; fi; pause_screen;;
 10) read -r -p 'Child directory name: ' n; if valid_name "$n"; then change_directory "$n"; else error 'Enter a directory name only.'; fi; pause_screen;;
 11) change_directory ..; pause_screen;;
 12) read -r -p 'Relative or absolute directory path: ' p; [[ -n "$p" ]] && change_directory "$p"; pause_screen;;
 13) read -r -p 'Name pattern (e.g. *.txt): ' p; [[ -n "$p" ]] && find "$current_dir" -maxdepth 1 -name "$p" -print; pause_screen;;
 14) printf '%s\n' "$current_dir"; pause_screen;; 15) break;; *) error 'Invalid option.'; sleep 1;; esac
done
