
#!/usr/bin/env bash

# ==========================================
# KALI TOOLKIT - FILE & DIRECTORY MANAGER
# ==========================================

# ---------- 1. Colour Palette ----------

RESET='\033[0m'
BOLD='\033[1m'

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'

# ---------- 2. Initial Directory ----------

current_dir="$HOME"

# ---------- 3. Reusable Functions ----------

success() {
    printf '%b[SUCCESS]%b %s\n' "$GREEN" "$RESET" "$1"
}

error() {
    printf '%b[ERROR]%b %s\n' "$RED" "$RESET" "$1"
}

warning() {
    printf '%b[WARNING]%b %s\n' "$YELLOW" "$RESET" "$1"
}

info() {
    printf '%b[INFO]%b %s\n' "$CYAN" "$RESET" "$1"
}

pause_screen() {
    echo
    read -r -p "Press Enter to continue..."
}

show_path() {
    printf '%bCurrent directory:%b %s\n' \
        "$CYAN" "$RESET" "$current_dir"
}

# CRUD names must stay inside current_dir.
# Paths, slashes, "." and ".." are not allowed.
valid_name() {
    local name="$1"

    [[ -n "$name" ]] &&
    [[ "$name" != "." ]] &&
    [[ "$name" != ".." ]] &&
    [[ "$name" != */* ]]
}

# Navigate using an absolute or relative path.
change_directory() {
    local target="$1"

    if [[ "$target" != /* ]]; then
        target="$current_dir/$target"
    fi

    if [[ -d "$target" ]]; then
        current_dir="$(cd -- "$target" && pwd -P)" || return 1
        success "Directory changed."
        show_path
        return 0
    else
        error "Directory not found: $target"
        return 1
    fi
}

# ---------- 4. Main Menu ----------

while true; do
    clear

    printf '%b%b' "$CYAN" "$BOLD"
    echo "╔════════════════════════════════════════════╗"
    echo "║              KALI TOOLKIT                  ║"
    echo "║       FILE & DIRECTORY MANAGER              ║"
    echo "╚════════════════════════════════════════════╝"
    printf '%b' "$RESET"

    show_path

    echo
    printf '%b[1]%b  List files and directories\n' "$GREEN" "$RESET"
    printf '%b[2]%b  View details\n' "$GREEN" "$RESET"
    printf '%b[3]%b  Create file\n' "$GREEN" "$RESET"
    printf '%b[4]%b  Create directory\n' "$GREEN" "$RESET"
    printf '%b[5]%b  Read file\n' "$GREEN" "$RESET"
    printf '%b[6]%b  Edit file\n' "$GREEN" "$RESET"
    printf '%b[7]%b  Rename file/directory\n' "$GREEN" "$RESET"
    printf '%b[8]%b  Copy file\n' "$GREEN" "$RESET"
    printf '%b[9]%b  Delete file/directory\n' "$GREEN" "$RESET"
    printf '%b[10]%b Enter child directory\n' "$GREEN" "$RESET"
    printf '%b[11]%b Go to parent directory\n' "$GREEN" "$RESET"
    printf '%b[12]%b Jump to directory path\n' "$GREEN" "$RESET"
    printf '%b[13]%b Search by name\n' "$GREEN" "$RESET"
    printf '%b[14]%b Show current path\n' "$GREEN" "$RESET"
    printf '%b[15]%b Exit Explorer\n' "$RED" "$RESET"

    echo
    printf '%b────────────────────────────────────────────%b\n' \
        "$MAGENTA" "$RESET"

    read -r -p "$(printf '%btoolkit%b > ' "$MAGENTA" "$RESET")" choice

    case "$choice" in

        # ---------- List ----------

        1)
            echo
            info "Directory contents:"
            ls --color=auto -lah -- "$current_dir"
            pause_screen
            ;;

        # ---------- Details ----------

        2)
            read -r -p "Enter file/directory name: " name

            if ! valid_name "$name"; then
                error "Enter a name only, not a path."
            elif [[ -e "$current_dir/$name" || -L "$current_dir/$name" ]]; then
                echo
                printf '%b━━━ DETAILS ━━━%b\n' "$MAGENTA" "$RESET"
                ls -ldh --color=always -- "$current_dir/$name"
                info "Full path:"
                realpath -m -- "$current_dir/$name"
            else
                error "File or directory not found."
            fi

            pause_screen
            ;;

        # ---------- Create File ----------

        3)
            read -r -p "New file name: " name

            if ! valid_name "$name"; then
                error "Invalid name."
            elif [[ -e "$current_dir/$name" || -L "$current_dir/$name" ]]; then
                warning "That name already exists."
            elif touch -- "$current_dir/$name"; then
                success "File created: $name"
                info "Path: $current_dir/$name"
            else
                error "Could not create file. Check permissions."
            fi

            pause_screen
            ;;

        # ---------- Create Directory ----------

        4)
            read -r -p "New directory name: " name

            if ! valid_name "$name"; then
                error "Invalid name."
            elif [[ -e "$current_dir/$name" || -L "$current_dir/$name" ]]; then
                warning "That name already exists."
            elif mkdir -- "$current_dir/$name"; then
                success "Directory created: $name"
                info "Path: $current_dir/$name"
            else
                error "Could not create directory. Check permissions."
            fi

            pause_screen
            ;;

        # ---------- Read File ----------

        5)
            read -r -p "File name to read: " name

            if ! valid_name "$name"; then
                error "Invalid name."
            elif [[ -f "$current_dir/$name" && ! -L "$current_dir/$name" && -r "$current_dir/$name" ]]; then
                printf '%b━━━ FILE CONTENT ━━━%b\n' "$CYAN" "$RESET"
                cat -- "$current_dir/$name"
                echo
                printf '%b━━━ END OF FILE ━━━%b\n' "$CYAN" "$RESET"
            else
                error "Regular readable file not found."
            fi

            pause_screen
            ;;

        # ---------- Edit File ----------

        6)
            read -r -p "File name to edit: " name

            if ! valid_name "$name"; then
                error "Invalid name."
                pause_screen
            elif [[ -f "$current_dir/$name" && ! -L "$current_dir/$name" && -w "$current_dir/$name" ]]; then
                nano -- "$current_dir/$name"
            else
                error "Writable regular file not found."
                pause_screen
            fi
            ;;

        # ---------- Rename ----------

        7)
            read -r -p "Existing name: " old_name
            read -r -p "New name: " new_name

            if ! valid_name "$old_name" || ! valid_name "$new_name"; then
                error "Names only. Paths are not allowed."
            elif [[ ! -e "$current_dir/$old_name" && ! -L "$current_dir/$old_name" ]]; then
                error "Source not found."
            elif [[ -e "$current_dir/$new_name" || -L "$current_dir/$new_name" ]]; then
                warning "Destination already exists."
            elif mv -- "$current_dir/$old_name" "$current_dir/$new_name"; then
                success "Renamed: $old_name -> $new_name"
            else
                error "Rename failed. Check permissions."
            fi

            pause_screen
            ;;

        # ---------- Copy File ----------

        8)
            read -r -p "File name to copy: " source
            read -r -p "New copy name: " destination

            if ! valid_name "$source" || ! valid_name "$destination"; then
                error "Names only. Paths are not allowed."
            elif [[ ! -f "$current_dir/$source" || -L "$current_dir/$source" ]]; then
                error "Source regular file not found."
            elif [[ -e "$current_dir/$destination" || -L "$current_dir/$destination" ]]; then
                warning "Destination already exists."
            elif cp -p -- "$current_dir/$source" "$current_dir/$destination"; then
                success "File copied: $source -> $destination"
            else
                error "Copy failed. Check permissions and disk space."
            fi

            pause_screen
            ;;

        # ---------- Delete ----------

        9)
            read -r -p "Name to delete: " name

            if ! valid_name "$name"; then
                error "Invalid name."
            elif [[ ! -e "$current_dir/$name" && ! -L "$current_dir/$name" ]]; then
                error "File or directory not found."
            else
                warning "Selected: $current_dir/$name"
                read -r -p "Type DELETE to confirm: " confirm

                if [[ "$confirm" == "DELETE" ]]; then
                    if [[ -d "$current_dir/$name" && ! -L "$current_dir/$name" ]]; then
                        if rmdir -- "$current_dir/$name"; then
                            success "Empty directory deleted."
                        else
                            error "Directory is not empty or deletion failed."
                        fi
                    elif rm -- "$current_dir/$name"; then
                        success "File deleted."
                    else
                        error "Deletion failed. Check permissions."
                    fi
                else
                    info "Deletion cancelled."
                fi
            fi

            pause_screen
            ;;

        # ---------- Enter Child Directory ----------

        10)
            read -r -p "Child directory name: " name

            if ! valid_name "$name"; then
                error "Enter a child directory name only."
                pause_screen
            elif [[ -d "$current_dir/$name" ]]; then
                change_directory "$name"
            else
                error "Child directory not found."
                pause_screen
            fi
            ;;

        # ---------- Parent Directory ----------

        11)
            change_directory ".."
            ;;

        # ---------- Jump to Path ----------

        12)
            echo "Examples: tools | ../tools | /mnt/p"
            read -r -p "Enter directory name or path: " path

            if [[ -n "$path" ]]; then
                change_directory "$path"
            else
                warning "Path cannot be empty."
            fi

            pause_screen
            ;;

        # ---------- Search ----------

        13)
            read -r -p "Enter name or part of name: " search_name

            if [[ -z "$search_name" ]]; then
                warning "Search name cannot be empty."
            else
                printf '%bSearch results:%b\n' "$CYAN" "$RESET"

                find "$current_dir" \
                    -iname "*$search_name*" \
                    -print 2>/dev/null
            fi

            pause_screen
            ;;

        # ---------- Current Path ----------

        14)
            show_path
            pause_screen
            ;;

        # ---------- Exit ----------

        15)
            success "Exiting File Manager."
            break
            ;;

        *)
            error "Invalid option. Choose 1-15."
            sleep 1
            ;;
    esac
done
