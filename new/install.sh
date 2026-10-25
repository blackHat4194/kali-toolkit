#!/usr/bin/env bash
set -u
BASE_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"; source "$BASE_DIR/config.sh"
heading 'PORTABLE TOOLKIT SETUP'; success "Project directory: $TOOLKIT_DIR"
required=(bash mkdir ls cat cp mv rm find); optional=(realpath git nano less ip ss ping getent tar gzip)
missing=(); optional_missing=()
for c in "${required[@]}"; do command -v "$c" >/dev/null 2>&1 || missing+=("$c"); done
for c in "${optional[@]}"; do command -v "$c" >/dev/null 2>&1 || optional_missing+=("$c"); done
ensure_project_dirs || { error 'Cannot create project directories; check permissions.'; exit 1; }
success 'Created/verified tools/, backups/, test-area/.'
((${#missing[@]})) && error "Missing required commands: ${missing[*]}" || success 'Required command check passed.'
((${#optional_missing[@]})) && warning "Optional commands missing: ${optional_missing[*]}" || success 'Optional command check passed.'
if [[ -r /etc/os-release ]]; then . /etc/os-release; printf 'Detected OS: %s\n' "${PRETTY_NAME:-unknown}"; fi
printf '\nNo packages were installed and no sudo commands were run.\nNext: ./main.sh\n'
