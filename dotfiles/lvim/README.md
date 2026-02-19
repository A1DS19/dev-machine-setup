# LVim Config

This is a personalized configuration for LunarVim, tailored for polyglot development with robust support for various languages and tools.

---

## Install formatters

- `cargo install stylua`
- `rustup component add rustfmt`
- `sudo apt install clang-format`
- `pip install black`
- `dotnet tool install -g csharpier` (for C# formatting)
- `npm install eslint prettier eslint-config-prettier eslint-plugin-prettier --save-dev` (for projects, not global)

---

## Supported Languages & Tools

**With full LSP support:**
- **Rust** - `rust_analyzer` + `rustfmt`
- **C/C++** - `clangd` + `clang-format`
- **TypeScript/JavaScript** - `tsserver` + `eslint` + `prettier`
- **Python** - `pyright` + `black` + `isort`
- **HTML/CSS** - `html` + `cssls` + `prettier`
- **Tailwind CSS** - `tailwindcss`
- **C#** - `omnisharp` + `csharpier`
- **JSON/YAML** - `jsonls` + `yamlls` + `prettier`
- **Lua** - `lua_ls` + `stylua`
- **Bash** - `bashls` + `shfmt`
- **Docker** - `dockerls`
- **Markdown** - `marksman` + `prettier`
- **TOML** - `taplo`
- **CMake** - `cmake` + `cmake-format`

---

## Additional Features

- **Git integration** - LazyGit
- **File explorer** - nvim-tree
- **Fuzzy finder** - Telescope with file browser
- **Debugging** - nvim-dap + dapui
- **Autocompletion** - nvim-cmp with LSP sources
- **Snippets** - LuaSnip with friendly-snippets
- **Session persistence** - persistence.nvim
- **Theme** - Dracula

---

## C# Setup (OmniSharp)

### Prerequisites
- Install .NET SDK 6.0+ (tested with .NET 9)
```bash
# Ubuntu/Debian
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y dotnet-sdk-8.0
# For other versions, see Microsoft's official documentation.

# Verify installation
dotnet --version
```

### Installation

1. **OmniSharp** is installed automatically by **Mason** when you first open a C# (`.cs`) file.
2. The configuration automatically attempts to:
   - Set the `DOTNET_ROOT` environment variable.
   - Configure OmniSharp with a default executable path.
   - Enable Roslyn analyzers and import completion.
3. **Important:** The default path and permissions may need to be corrected. See the **Troubleshooting** section below.

### Troubleshooting

If the C# LSP fails to start, you may encounter one of two common issues:

#### 1. Permission Denied Error (`EACCES`)

- **Symptom:** You see an error message containing `EACCES: permission denied`.
- **Cause:** The `OmniSharp` executable downloaded by Mason does not have the necessary permissions to be run.
- **Fix:** Grant execute permission to the file by running the following command in your terminal:

```bash
chmod u+x ~/.local/share/lvim/mason/packages/omnisharp/libexec/OmniSharp
```

#### 2. Incorrect Executable Path

- **Symptom:** You see an error like `No such file or directory` or the LSP log shows a duplicated path (e.g., `/home/user/home/user/...`).
- **Cause:** The hardcoded path in the configuration doesn't match where Mason installed the executable.
- **Fix:**
  - First, find the correct path to the executable:
    ```bash
    find ~/.local/share -type f -name "OmniSharp"
    ```
  - Then, update your `config.lua`. In the `neovim/nvim-lspconfig` plugin section, find the `lspconfig.omnisharp.setup` block and update the `cmd` table with the correct path:
    ```lua
    -- in config.lua
    cmd = {
      os.getenv("HOME") .. "/.local/share/lvim/mason/packages/omnisharp/libexec/OmniSharp",
      "--languageserver",
      "--hostPID",
      tostring(vim.fn.getpid()),
    },
    ```

### Known Issues

- Semantic tokens may show errors in logs (this doesn't seem to affect functionality).
- IntelliSense, go-to-definition, and autocomplete work correctly after setup.

### Notes

- All languages are configured for full LSP support including formatting, linting, and IntelliSense.
- C# support has been restored and stabilized with OmniSharp-Roslyn.
