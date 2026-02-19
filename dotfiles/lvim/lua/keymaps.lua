-- General Key Mappings
lvim.keys.normal_mode["<leader>ff"] = "<cmd>Telescope find_files<CR>"
lvim.keys.normal_mode["<leader>fg"] = "<cmd>Telescope live_grep<CR>"
lvim.keys.normal_mode["<leader>fb"] = "<cmd>Telescope buffers<CR>"
lvim.keys.normal_mode["<leader>fh"] = "<cmd>Telescope help_tags<CR>"
lvim.keys.normal_mode["<leader>bd"] = "<cmd>bd<CR>"
lvim.keys.normal_mode["<leader>bn"] = "<cmd>bn<CR>"
lvim.keys.normal_mode["<leader>bp"] = "<cmd>bp<CR>"
lvim.keys.normal_mode["<leader>fgf"] = function()
  require('telescope.builtin').live_grep({
    search_dirs = { vim.fn.expand('%:p') }
  })
end

-- File Browser
lvim.keys.normal_mode["<leader>e"] = "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>"

-- Session Management
lvim.keys.normal_mode["<leader>ss"] = "<cmd>lua require('persistence').save()<CR>"
lvim.keys.normal_mode["<leader>sr"] = "<cmd>lua require('persistence').load()<CR>"
lvim.keys.normal_mode["<leader>sn"] = "<cmd>lua require('persistence').stop()<CR>"
lvim.keys.normal_mode["<leader>sl"] = "<cmd>lua require('persistence').load({ last = true })<CR>"
lvim.keys.normal_mode["<leader>sa"] = "<cmd>lua save_session_with_name()<CR>"

-- Custom function to save session with a name
function save_session_with_name()
  local session_name = vim.fn.input("Session Name: ")
  if session_name ~= "" then
    require("persistence").save(session_name)
  else
    print("Session name cannot be empty!")
  end
end

-- Enhanced Key Mappings with which-key
lvim.builtin.which_key.mappings["f"] = {
  name = "Find",
  f = { "<cmd>Telescope find_files<CR>", "Find Files" },
  g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
  b = { "<cmd>Telescope buffers<CR>", "Buffers" },
  h = { "<cmd>Telescope help_tags<CR>", "Help Tags" },
}

lvim.builtin.which_key.mappings["e"] = { "<cmd>Telescope file_browser<CR>", "File Browser" }

-- Terminal
lvim.builtin.terminal.active = true
lvim.builtin.terminal.open_mapping = "<leader>tt"

-- NvimTree mappings
lvim.keys.normal_mode["<C-t>"] = ":NvimTreeToggle<CR>"

-- Go to Definition and Go to Implementation
lvim.keys.normal_mode["gd"] = "<cmd>lua vim.lsp.buf.definition()<CR>"
lvim.keys.normal_mode["gI"] = "<cmd>lua vim.lsp.buf.implementation()<CR>"

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {
    "*.rs", "*.c", "*.cpp", "*.cs", "*.ts", "*.tsx", "*.js", "*.jsx", "*.py", "*.lua", "*.hpp", "*.h",
    "*.json",
    "*.yaml", "*.yml",
    "*.toml",
    "*.sh", "*.bash",
    "*.html",
    "*.css", "*.scss",
    "*.md",
    "*.cmake",
    "CMakeLists.txt",
    "Makefile",
    "*.make",
    "Dockerfile",
    "*.dockerfile",
    "*.go",
    "*.java",
    "*.php",
    "*.rb",
    "*.vim",
    "*.xml",
    "*.svg",
    "*.vert",
    "*.frag",
    "*.glsl"
  },
  callback = function()
    vim.lsp.buf.format({ async = false })
    print("File formatted and saved!")
  end,
})
