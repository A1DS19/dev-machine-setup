# Dev Machine Setup

Ansible playbook to automate my developer environment.

## What gets installed

| Category | Tools |
|----------|-------|
| **Build tools** | GCC, G++, Clang, CMake, Make, Ninja, Ccache |
| **Editors** | Neovim (+ config), VSCode, LunarVim |
| **Terminal** | Warp, Zsh, Starship, lazygit (`lg`), yazi (`y`), btop, atuin, glow, ncdu, eza, bat, fzf, zoxide, git-delta |
| **Browsers** | Google Chrome |
| **Embedded** | ESP-IDF v5.5.3, Arduino CLI, KiCad, generate-c/cpp-project |
| **Containers** | Docker CE + Compose plugin |
| **Languages** | Python 3, Node.js, pnpm, Anaconda/Conda |
| **Apps** | DataGrip, Android Studio, Postman |

---

## Requirements

- Fresh **Fedora Workstation** install
- Internet connection
- A user account with `sudo` privileges

---

## 1. Install Ansible

```bash
sudo dnf install ansible git -y
```

---

## 2. Get this repo

```bash
git clone https://github.com/A1DS19/dev-machine-setup.git ~/projects/dev-machine-setup
cd ~/projects/dev-machine-setup
```

---

## 3. Install Ansible community modules

```bash
ansible-galaxy collection install community.general
```

---

## 4. Run the playbook

```bash
ansible-playbook playbook.yml -i inventory.ini --ask-become-pass
```

Enter your sudo password when prompted. The playbook is **idempotent** — safe to run multiple times.

---

## 5. Migrate files from old machine

Run this **from your old machine**, replacing `user@ip` with your new machine's details:

```bash
./sync.sh user@<new-machine-ip>
```

This copies:
- `~/projects/` → all your projects

---

## Post-install notes

### Terminal aliases

| Alias | Command | What it does |
|-------|---------|--------------|
| `ls` | `eza --icons --group-directories-first` | Better `ls` with icons |
| `cat` | `bat --paging=never` | Syntax-highlighted file viewer |
| `cd` | `zoxide` (`z`) | Smart directory jumping |
| `lg` | `lazygit` | Terminal UI for git |
| `y` | `yazi` | Terminal file manager |
| `du` | `ncdu` | Interactive disk usage |

### ESP-IDF
Source the environment before working on ESP32 projects. An alias is added to your shell automatically:

```bash
get_idf        # activates ESP-IDF environment in current session
```

To support additional chip targets, edit `tasks/esp-idf.yml` before running:
```bash
# Change this line:
./install.sh esp32

# To include more targets:
./install.sh esp32,esp32s2,esp32s3
```

### Docker
Log out and back in after the playbook finishes so your user's Docker group membership takes effect.

```bash
# Verify:
docker run hello-world
```

### Anaconda
Conda is initialized in `.bashrc`. Restart your terminal or run:

```bash
source ~/.bashrc
conda --version
```
---

## Repo structure

```
dev-machine-setup/
├── playbook.yml          # main playbook
├── inventory.ini         # localhost target
├── sync.sh               # migrate files from old machine
└── tasks/
    ├── dnf.yml
    ├── chrome.yml
    ├── vscode.yml
    ├── docker.yml
    ├── flatpaks.yml       # Warp, DataGrip, Android Studio, Postman
    ├── pnpm.yml
    ├── esp-idf.yml
    ├── arduino-cli.yml
    ├── generate-c-cpp-project.yml
    ├── anaconda.yml
    ├── ai-clis.yml        # Claude, Gemini, Codex
    ├── neovim-config.yml
    ├── lvim.yml
    └── terminal.yml       # Zsh, Starship, lazygit, yazi, atuin, nerd fonts, ...
```
