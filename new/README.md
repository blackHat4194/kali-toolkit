# Portable Linux Toolkit

A modular Bash learning toolkit intended for Kali Linux, Ubuntu, Parrot OS, and Linux distributions running inside WSL. Compatibility depends on available commands and permissions, so test it on each target environment.

## Modules
- `explorer.sh`: directory-local file operations and relative/absolute navigation.
- `file_organizer.sh`: preview and group top-level files by extension.
- `backup.sh`: create `.tar.gz` archives, list them, and restore into a new destination.
- `system_info.sh`: OS, kernel, uptime, memory, disk and network interface information.
- `network_diagnostic.sh`: basic IP, route, DNS, ping and listening-socket checks.
- `workspace.sh`: clone repositories into `tools/` and inspect their README.
- `install.sh`: create project folders and report missing commands; it does not install packages or use sudo.

## Setup
```bash
chmod +x *.sh
./install.sh
./main.sh
```

## Clone a learning repository
```bash
git clone https://github.com/OWNER/REPOSITORY.git tools/REPOSITORY
```
Inspect the source, license and dependencies before running third-party code. Use security tools only in systems/labs you own or have explicit authorization to test.

## Portability notes
- Uses Bash and common Linux utilities. Missing optional commands are reported rather than installed automatically.
- WSL networking/kernel information can differ from native Linux.
- Explorer is not a security sandbox. Avoid running as root and test destructive operations in `test-area/`.
- Backups may contain sensitive information. Verify them before deleting originals.
