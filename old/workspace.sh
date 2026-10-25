
#!/usr/bin/env bash

RESET='\033[0m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'

tools_dir="$HOME/kali-toolkit/tools"

mkdir -p "$tools_dir"

while true; do
    clear
    printf '%b=== GITHUB LEARNING WORKSPACE ===%b\n' "$CYAN" "$RESET"
    echo "Repository directory: $tools_dir"
    echo
    echo "1. List repositories"
    echo "2. Read a repository README"
    echo "3. Show repository path"
    echo "4. Return to main menu"
    echo

    read -r -p "Choose an option: " choice

    case "$choice" in
        1)
            echo
            found=0

            for repo in "$tools_dir"/*/; do
                [[ -d "$repo" ]] || continue
                printf '%b%s%b\n' "$GREEN" "${repo%/}" "$RESET"
                found=1
            done

            if [[ "$found" -eq 0 ]]; then
                echo "No repositories found."
                echo "Clone a repository into the tools directory first."
            fi

            read -r -p "Press Enter to continue..."
            ;;

        2)
            read -r -p "Repository folder name: " repo_name

            if [[ -z "$repo_name" || "$repo_name" == */* ||
                  "$repo_name" == "." || "$repo_name" == ".." ]]; then
                echo "Enter a repository folder name only."
            elif [[ ! -d "$tools_dir/$repo_name" ]]; then
                echo "Repository not found."
            else
                readme=""

                for candidate in \
                    "$tools_dir/$repo_name/README.md" \
                    "$tools_dir/$repo_name/README" \
                    "$tools_dir/$repo_name/readme.md"; do
                    if [[ -f "$candidate" ]]; then
                        readme="$candidate"
                        break
                    fi
                done

                if [[ -n "$readme" ]]; then
                    if command -v glow >/dev/null 2>&1; then
                        glow "$readme"
                    else
                        less "$readme"
                    fi
                else
                    echo "No README file found."
                fi
            fi

            read -r -p "Press Enter to continue..."
            ;;

        3)
            read -r -p "Repository folder name: " repo_name

            if [[ -d "$tools_dir/$repo_name" &&
                  "$repo_name" != */* &&
                  "$repo_name" != "." &&
                  "$repo_name" != ".." ]]; then
                printf '%bPath:%b %s\n' \
                    "$GREEN" "$RESET" \
                    "$(realpath "$tools_dir/$repo_name")"
            else
                echo "Repository not found or invalid name."
            fi

            read -r -p "Press Enter to continue..."
            ;;

        4)
            break
            ;;

        *)
            printf '%bInvalid option.%b\n' "$RED" "$RESET"
            sleep 1
            ;;
    esac
done
