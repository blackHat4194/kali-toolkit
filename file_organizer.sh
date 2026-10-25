
#!/usr/bin/env bash
echo "runn"
echo "========== FILE ORGANIZER =========="
read -r -p "Enter folder path: " target

if [[ ! -d "$target" ]]; then
    echo "Error: Folder does not exist."
    read -r -p "Press Enter to return..."
    exit 1
fi

target="$(realpath "$target")"

echo
echo "Files to organize: $target"
echo "Preview:"
find "$target" -maxdepth 1 -type f -printf '%f\n'
echo

read -r -p "Move files into extension folders? (y/N): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Cancelled. No files moved."
    read -r -p "Press Enter to return..."
    exit 0
fi

shopt -s nullglob dotglob

for file in "$target"/*; do
    [[ -f "$file" ]] || continue

    filename="${file##*/}"

    if [[ "$filename" != *.* || "$filename" == .* && "$filename" != *.*.* ]]; then
        category="No_Extension"
    else
        category="${filename##*.}"
        category="${category,,}"
    fi

    [[ "$category" == "$filename" ]] && category="No_Extension"

    destination="$target/$category"
    mkdir -p "$destination"

    if [[ ! -e "$destination/$filename" ]]; then
        mv -- "$file" "$destination/"
        echo "Moved: $filename -> $category/"
    else
        echo "Skipped: $filename (destination already exists)"
    fi
done

shopt -u nullglob dotglob

echo
echo "Organization completed."
read -r -p "Press Enter to return..."
