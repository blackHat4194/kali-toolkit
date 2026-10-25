#!/usr/bin/env bash
BASE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"; source "$BASE_DIR/config.sh"; ensure_project_dirs
while true; do
 clear 2>/dev/null || true; heading 'BACKUP & RESTORE'; printf 'Backup directory: %s\n\n1. Create compressed backup\n2. List backups\n3. Restore into a new directory\n4. Return\n\n' "$BACKUPS_DIR"; read -r -p 'Choose: ' c || break
 case "$c" in
 1) read -r -p 'Source file or directory: ' src; if [[ ! -e "$src" ]]; then error 'Source does not exist.'; elif ! have_cmd tar || ! have_cmd gzip; then error 'tar/gzip unavailable.'; else src="$(realpath -- "$src" 2>/dev/null || printf '%s' "$src")"; n="$(basename -- "$src")"; parent="$(dirname -- "$src")"; archive="$BACKUPS_DIR/${n}_$(date +%Y%m%d_%H%M%S).tar.gz"; if tar -czf "$archive" -C "$parent" -- "$n"; then success "Created $archive"; else error 'Backup failed.'; rm -f -- "$archive"; fi; fi; pause_screen;;
 2) found=0; for a in "$BACKUPS_DIR"/*.tar.gz; do [[ -f "$a" ]] || continue; ls -lh -- "$a"; found=1; done; ((found)) || info 'No backups found.'; pause_screen;;
 3) read -r -p 'Archive filename in backups/: ' n; if [[ -z "$n" || "$n" == */* || ! -f "$BACKUPS_DIR/$n" ]]; then error 'Archive not found or invalid filename.'; elif ! tar -tzf "$BACKUPS_DIR/$n" >/dev/null 2>&1; then error 'Invalid archive.'; else read -r -p 'NEW destination path (must not exist): ' dest; if [[ -z "$dest" || -e "$dest" ]]; then error 'Destination must be a new path.'; else mkdir -p -- "$dest" && tar -xzf "$BACKUPS_DIR/$n" -C "$dest" && success "Restored into $dest" || error 'Restore failed; inspect destination.'; fi; fi; pause_screen;;
 4) break;; *) error 'Invalid option.'; sleep 1;; esac
done
