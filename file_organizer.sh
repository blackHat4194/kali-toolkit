#!/usr/bin/env bash
BASE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"; source "$BASE_DIR/config.sh"
read -r -p 'Directory to organize (blank = current directory): ' target; target="${target:-$PWD}"
[[ -d "$target" ]] || { error 'Directory not found.'; exit 1; }; target="$(cd -- "$target" && pwd -P)" || exit 1
heading 'FILE ORGANIZER PREVIEW'; printf 'Target: %s\n' "$target"; find "$target" -maxdepth 1 -type f -printf '%f\n' 2>/dev/null | sort
warning 'Files will be moved into folders named by extension. No recursion; conflicts are skipped.'
read -r -p 'Type ORGANIZE to proceed: ' confirm; [[ "$confirm" == ORGANIZE ]] || { info 'Cancelled.'; exit 0; }
moved=0
while IFS= read -r -d '' f; do n="${f##*/}"; if [[ "$n" != *.* || "$n" == .* && "$n" != *.*.* ]]; then ext=no_extension; else ext="${n##*.}"; [[ -n "$ext" ]] || ext=no_extension; fi; d="$target/$ext"; mkdir -p -- "$d" || continue; [[ -e "$d/$n" || -L "$d/$n" ]] && { warning "Skipped existing: $d/$n"; continue; }; if mv -- "$f" "$d/$n"; then ((moved+=1)); fi; done < <(find "$target" -maxdepth 1 -type f -print0)
success "Moved $moved file(s)."; pause_screen
