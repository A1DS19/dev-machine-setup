-- Load settings
require("settings")

-- Load plugins
require("plugins")

-- Load key mappings
require("keymaps")

-- GLSL file type detection
vim.filetype.add({
  extension = {
    vert = "glsl",
    frag = "glsl",
    ino = "arduino",
  },
})

-- Assembly file type detection (AVR, x86, x86_64, ARM/STM32)
vim.filetype.add({
  extension = {
    asm = "asm",
    s = "asm",
    S = "asm",
    inc = "asm",
  },
  pattern = {
    [".*%.asm"] = "asm",
    [".*%.s"] = "asm",
    [".*%.S"] = "asm",
  },
})

-- Assembly file icons
require("nvim-web-devicons").set_icon({
  asm = { icon = "", color = "#529aba", name = "Asm" },
  s   = { icon = "", color = "#529aba", name = "AsmS" },
  S   = { icon = "", color = "#529aba", name = "AsmSUpper" },
  inc = { icon = "", color = "#529aba", name = "AsmInc" },
})

-- Arduino Language Server setup
vim.list_extend(lvim.lsp.installer.setup.ensure_installed, {
  "arduino_language_server",
})

require("lvim.lsp.manager").setup("arduino_language_server", {
  cmd = {
    "arduino-language-server",
    "-cli-config", vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
    "-fqbn", "arduino:avr:uno", -- Change to your board
    "-cli", "arduino-cli",
    "-clangd", "clangd",
  },
})

-- Auto format on save for Arduino files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.ino",
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 1000 })
  end,
})
