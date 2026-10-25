#!/usr/bin/env bash
TOOLKIT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
TOOLS_DIR="${TOOLS_DIR:-$TOOLKIT_DIR/tools}"
BACKUPS_DIR="${BACKUPS_DIR:-$TOOLKIT_DIR/backups}"
TEST_AREA_DIR="${TEST_AREA_DIR:-$TOOLKIT_DIR/test-area}"
if [[ -t 1 && -z "${NO_COLOR:-}" ]]; then RESET=$'\033[0m'; RED=$'\033[0;31m'; GREEN=$'\033[0;32m'; YELLOW=$'\033[0;33m'; CYAN=$'\033[0;36m'; else RESET='' RED='' GREEN='' YELLOW='' CYAN=''; fi
success(){ printf '%b[+]%b %s\n' "$GREEN" "$RESET" "$*"; }
error(){ printf '%b[!]%b %s\n' "$RED" "$RESET" "$*" >&2; }
warning(){ printf '%b[*]%b %s\n' "$YELLOW" "$RESET" "$*"; }
info(){ printf '%b[-]%b %s\n' "$CYAN" "$RESET" "$*"; }
heading(){ printf '\n%b=== %s ===%b\n' "$CYAN" "$*" "$RESET"; }
pause_screen(){ printf '\n'; read -r -p 'Press Enter to continue...' _ || true; }
have_cmd(){ command -v "$1" >/dev/null 2>&1; }
ensure_project_dirs(){ mkdir -p -- "$TOOLS_DIR" "$BACKUPS_DIR" "$TEST_AREA_DIR"; }
