# Kali Toolkit

A modular Bash-based toolkit for learning Linux, managing files,
inspecting system information, and running basic network diagnostics
inside Kali Linux on WSL.

> **Learning and safety note:** Use this toolkit only on systems,
> networks, repositories, and devices you own or have explicit
> permission to test. Treat third-party GitHub tools as untrusted code.
> This project can help you clone, inspect, document, and organize
> repositories, but it should not automatically execute unknown scripts
> or phishing/camera-capture tools. Tools such as CamPhish can collect
> camera images through social-engineering workflows; do not use them
> against other people or devices. For security learning, use a
> controlled lab and consent-based demonstrations.

## Features

-   **Interactive main menu** to launch toolkit modules.
-   **File & Directory Explorer** for listing, navigating, creating,
    reading, editing, copying, renaming, and deleting files within the
    selected working directory.
-   **File Organizer** to sort files by extension after preview and
    confirmation.
-   **Backup Tool** to create timestamped backups.
-   **System Information** for username, hostname, OS, kernel, uptime,
    memory, disk, and IP information.
-   **Network Diagnostics** for local network configuration, routes, DNS
    resolution, and connectivity checks.
-   **Learning Tools Workspace** to keep cloned GitHub repositories in
    one place for review and authorized lab use.

## Suggested project layout

``` text
~/kali-toolkit/
├── main.sh
├── explorer.sh
├── file_organizer.sh
├── backup.sh
├── system_info.sh
├── network_diagnostic.sh
├── tools/
│   └── <cloned-repository>/
├── backups/
├── test-area/
└── README.md
```

### What each file does

  File/folder               Purpose
  ------------------------- ---------------------------------------------------------
  `main.sh`                 Main interactive menu and module launcher
  `explorer.sh`             File and directory CRUD operations
  `file_organizer.sh`       Organizes files into extension-based folders
  `backup.sh`               Creates backups of selected folders
  `system_info.sh`          Displays system details
  `network_diagnostic.sh`   Runs basic, non-invasive network checks
  `tools/`                  Stores GitHub repositories for learning and code review
  `backups/`                Stores backup copies
  `test-area/`              Safe area for practicing file operations

Keep `file_organizer.sh` and `backup.sh`. They should become menu
modules rather than being merged into the Explorer. Each script has one
responsibility, which makes the project easier to understand, test, and
maintain.

## Requirements

Run these commands in your Kali WSL terminal:

``` bash
sudo apt update
sudo apt install -y git curl dnsutils iproute2 iputils-ping procps coreutils
```

Some diagnostic commands may require additional packages or permissions.
The toolkit should report missing commands clearly instead of silently
failing.

## Initial setup

``` bash
mkdir -p ~/kali-toolkit/{backups,test-area,tools}
cd ~/kali-toolkit
```

Create the project files as needed:

``` bash
touch main.sh explorer.sh file_organizer.sh backup.sh
touch system_info.sh network_diagnostic.sh
```

Make scripts executable when you are ready to run them:

``` bash
chmod +x *.sh
```

Launch the main menu:

``` bash
./main.sh
```

## File Explorer behaviour

The Explorer tracks a `current_dir` value. File operations should use
names relative to that directory, not arbitrary paths.

Example: - Current directory: `/home/kali` - Enter child directory:
`tools` - Current directory becomes `/home/kali/tools` - Create
`notes.txt`: it is created inside `/home/kali/tools`

Use navigation options to change the current directory before performing
CRUD operations there. Deletion should require explicit confirmation.
The basic version should delete only files and empty directories, not
recursively remove directory trees.

**Important limitation:** shell-script checks are safeguards for normal
use, not a complete security boundary. Be careful with symbolic links,
permissions, and destructive operations. Test changes in `test-area/`
first.

## GitHub learning workspace

Keep repositories in `~/kali-toolkit/tools/`. For example:

``` bash
cd ~/kali-toolkit/tools
git clone <repository-url>
```

Replace `<repository-url>` with the repository's actual clone URL.

Before running code from a repository:

1.  Read its `README.md` and license.
2.  Inspect scripts before executing them.
3.  Check install commands and dependencies.
4.  Prefer a disposable VM or isolated lab for unknown tools.
5.  Do not run scripts as root unless there is a clear, justified need.
6.  Never enter real credentials, tokens, or private information into an
    untrusted tool.
7.  Use only targets and devices for which you have explicit permission.

The toolkit should initially provide repository browsing and launch
instructions, not a generic "run any script" button. Any future launcher
should use a reviewed allowlist and display the exact command for
confirmation.

## Network diagnostics scope

The Network Diagnostic module should focus on local, non-invasive
checks, such as:

-   `ip addr` for local network interfaces and IP addresses.
-   `ip route` for the routing table and default gateway.
-   `getent hosts example.com` or `nslookup example.com` for DNS
    resolution.
-   `ping -c 4 example.com` for basic reachability, where permitted.
-   `ss -tuln` for local listening sockets.

Use these checks on your own system and network. Avoid scanning or
probing networks without authorization.

## Development plan

1.  Stabilize and test `explorer.sh`.
2.  Connect the Explorer to `main.sh`.
3.  Keep `file_organizer.sh` and `backup.sh` as separate modules.
4.  Add `system_info.sh`.
5.  Add `network_diagnostic.sh`.
6.  Add a safe repository manager for listing and reviewing cloned
    tools.
7.  Add module-by-module tests and document each command.

## Troubleshooting

### `Permission denied`

Check the file path and permissions:

``` bash
ls -l ./main.sh
chmod +x ./main.sh
```

### A command is missing

Check whether it is installed:

``` bash
command -v git
command -v ip
command -v ping
command -v nslookup
```

Install missing packages using `apt` only after checking which package
provides the command.

### A path does not work

Print the current directory:

``` bash
pwd
```

For Windows drives in WSL, paths commonly appear under `/mnt/`, for
example `/mnt/c/` or `/mnt/p/`, depending on your setup.

------------------------------------------------------------------------

**Project status:** Learning project. Review and test each module before
relying on it. Backups should be stored on a separate location when
possible, not only inside the same WSL filesystem.
