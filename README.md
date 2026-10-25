# 🐉 Kali Toolkit

**A colorful, modular and portable Bash toolkit for Linux system utilities and learning workflows.**

Kali Toolkit is a menu-driven collection of Bash scripts designed to simplify common file operations, backups, system information checks, basic network diagnostics, and Git repository management.

The project aims to support Kali Linux, Ubuntu, Parrot OS, and Linux distributions running through WSL, subject to available commands and environment limitations.

## ✨ Features

- 📁 **File & Directory Explorer:** Create, read, edit, copy, rename, search, and delete files or directories.
- 🗂️ **File Organizer:** Preview file categories and organize files into folders.
- 💾 **Backup & Restore:** Create compressed backups and restore them to a selected destination.
- 🖥️ **System Information:** View operating system, kernel, memory, uptime, disk usage, and network interfaces.
- 🌐 **Network Diagnostics:** Inspect local IP addresses, routing, DNS resolution, ping connectivity, and listening sockets.
- 📦 **Learning Workspace:** Clone Git repositories, browse project folders, and read README files.
- 🎨 **Consistent Terminal UI:** Shared colors, headings, status messages, and menu styling.
- 🐧 **Portability Focus:** Resolve project paths dynamically and detect optional dependencies.

## 🧰 Technology

- Bash
- Standard Linux command-line utilities
- Git for repository management
- Optional utilities depending on the feature and environment

## 🖥️ Compatibility

Target environments:

- Kali Linux
- Ubuntu
- Parrot OS
- WSL with a supported Linux distribution

Compatibility depends on installed commands, permissions, kernel capabilities, and environment configuration. Each target environment should be tested before relying on the toolkit.

## 🚀 Getting Started

### 1. Install prerequisites

Install Bash and Git using your distribution's package manager if they are not already available.

### 2. Clone this repository

```bash
git clone https://github.com/YOUR_USERNAME/kali-toolkit.git
cd kali-toolkit
```

Replace `YOUR_USERNAME` with your GitHub username.

### 3. Set script permissions

```bash
chmod u+x ./*.sh
```

### 4. Run the setup check

```bash
./install.sh
```

### 5. Launch the toolkit

```bash
./main.sh
```

Run the toolkit as your normal user for routine tasks. Avoid running the entire toolkit with `sudo`.

## 📂 Project Structure

```text
kali-toolkit/
├── main.sh
├── config.sh
├── install.sh
├── explorer.sh
├── file_organizer.sh
├── backup.sh
├── system_info.sh
├── network_diagnostic.sh
├── workspace.sh
├── docs/
├── tools/
├── backups/
└── test-area/
```

## 🧪 Safe Testing

Use `test-area/` for experiments before applying file operations to important data.

Review backup destinations before restoring files. Inspect third-party repository source code and documentation before executing it.

## 🔐 Security & Responsible Use

This toolkit is intended for system administration, programming practice, and authorized security learning.

Network diagnostics are intended for basic local troubleshooting. Use any third-party security tools only on systems and environments where you have explicit authorization.

Cloning a repository does not make its code safe. Review its license, dependencies, and behavior before running it.

## 🛣️ Roadmap

- [ ] Complete portable installation and dependency checks
- [ ] Validate behavior on Kali Linux, Ubuntu, Parrot OS, and WSL
- [ ] Improve backup validation and recovery guidance
- [ ] Add automated shell syntax checks
- [ ] Add usage examples and screenshots
- [ ] Document module-specific dependencies

## 🤝 Contributing

Contributions, bug reports, and suggestions are welcome. Please read [CONTRIBUTING.md](CONTRIBUTING.md) before submitting changes.

## 📜 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## ⚠️ Disclaimer

This project is provided for educational and practical use. It is supplied "as is", without warranties. Users are responsible for reviewing commands and ensuring they have permission to perform their intended actions.
