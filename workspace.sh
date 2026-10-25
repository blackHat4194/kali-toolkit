#!/usr/bin/env bash
BASE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"; source "$BASE_DIR/config.sh"; ensure_project_dirs
while true; do
 clear 2>/dev/null || true; heading 'GIT REPOSITORY WORKSPACE'; printf 'Repository directory: %s\n\n1. List folders\n2. Clone repository into tools/\n3. Read README\n4. Print repository path\n5. Show tools/ path\n6. Return\n\n' "$TOOLS_DIR"; read -r -p 'Choose: ' c || break
 case "$c" in
 1) found=0; for r in "$TOOLS_DIR"/*/; do [[ -d "$r" ]] || continue; printf '%s\n' "${r%/}"; found=1; done; ((found)) || info 'No folders yet.'; pause_screen;;
 2) if ! have_cmd git; then error 'Git is not installed.'; else read -r -p 'Repository URL: ' url; read -r -p 'Destination folder name: ' folder; if [[ -z "$url" || "$url" == -* || -z "$folder" || "$folder" == */* || "$folder" == . || "$folder" == .. ]]; then error 'Invalid URL or folder name.'; elif [[ -e "$TOOLS_DIR/$folder" ]]; then error 'Destination already exists.'; else git clone -- "$url" "$TOOLS_DIR/$folder"; fi; fi; pause_screen;;
 3) read -r -p 'Repository folder name: ' folder; if [[ -z "$folder" || "$folder" == */* || "$folder" == . || "$folder" == .. || ! -d "$TOOLS_DIR/$folder" ]]; then error 'Invalid or missing folder.'; else f=''; for x in "$TOOLS_DIR/$folder/README.md" "$TOOLS_DIR/$folder/README" "$TOOLS_DIR/$folder/readme.md"; do [[ -f "$x" ]] && { f="$x"; break; }; done; if [[ -n "$f" ]]; then if have_cmd glow; then glow "$f"; elif have_cmd less; then less -- "$f"; else cat -- "$f"; fi; else warning 'README not found.'; fi; fi; pause_screen;;
 4) read -r -p 'Repository folder name: ' folder; if [[ -n "$folder" && "$folder" != */* && "$folder" != . && "$folder" != .. && -d "$TOOLS_DIR/$folder" ]]; then printf '%s\n' "$TOOLS_DIR/$folder"; else error 'Folder not found.'; fi; pause_screen;;
 5) printf '%s\n' "$TOOLS_DIR"; pause_screen;; 6) break;; *) error 'Invalid option.'; sleep 1;; esac
done
