lvim.plugins = {
  { "lunarvim/colorschemes" },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({ input = { enabled = false } })
    end,
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    config = true,
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("dracula").setup({
        transparent_bg = false,
        italic_comments = true,
      })
      vim.cmd("colorscheme dracula")
    end,
  },
  {
    "rafamadriz/friendly-snippets",
    lazy = false,
    priority = 1001,
  },
  {
    "windwp/nvim-autopairs",
    lazy = false,
    priority = 1000,
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = false,
    priority = 1000,
  },
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    priority = 1000,
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = false,
    priority = 1000,
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "b0o/schemastore.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    priority = 1000,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions
      require("telescope").setup({
        defaults = {
          mappings = {
            n = {
              ["s"] = actions.select_horizontal,
              ["v"] = actions.select_vertical,
            },
            i = {
              ["<C-s>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
            },
          },
        },
        extensions = {
          file_browser = {
            theme = "dropdown",
            hijack_netrw = false,
            layout_strategy = "horizontal",
            layout_config = {
              width = 0.8,
              height = 0.9,
              prompt_position = "bottom",
              mirror = false,
            },
            mappings = {
              ["n"] = {
                ["<A-c>"] = fb_actions.create,
                ["<S-CR>"] = fb_actions.create_from_prompt,
                ["<A-r>"] = fb_actions.rename,
                ["<A-m>"] = fb_actions.move,
                ["<A-y>"] = fb_actions.copy,
                ["<A-d>"] = fb_actions.remove,
                ["<C-o>"] = fb_actions.open,
                ["<C-g>"] = fb_actions.goto_parent_dir,
                ["<C-e>"] = fb_actions.goto_home_dir,
                ["<C-w>"] = fb_actions.goto_cwd,
                ["<C-t>"] = fb_actions.change_cwd,
                ["<C-f>"] = fb_actions.toggle_browser,
                ["<C-h>"] = fb_actions.toggle_hidden,
                ["<C-s>"] = fb_actions.toggle_all,
                ["<BS>"] = fb_actions.backspace,
              },
            },
          },
        },
      })
      pcall(require("telescope").load_extension, "file_browser")
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = true,
    priority = 1000,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = false,
    priority = 1000,
    build = "make",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup({
        dir = vim.fn.stdpath("data") .. "/sessions/",
        options = { "buffers", "curdir", "tabpages", "winsize" },
        autoload = true,
        autosave = {
          enabled = true,
          events = { "BufLeave", "VimLeavePre" },
          last_session = true,
        },
        telescope = { enabled = true, open_cmd = "Telescope" },
      })
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  ------------------------------------------------------------------
  -- GIT INTEGRATION
  ------------------------------------------------------------------
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "LazyGit",
    keys = { { "<leader>gg" } },
    config = function()
      vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })
    end,
  },

  ------------------------------------------------------------------
  -- FILE EXPLORER
  ------------------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        update_cwd = false,
        update_focused_file = {
          enable = false,
          update_cwd = false,
        },
        view = {
          width = 35,
          side = "left",
          number = false,
          relativenumber = false,
        },
        filters = {
          dotfiles = false,
          git_clean = false,
          git_ignored = false,
          custom = {},
        },
        git = {
          enable = true,
          ignore = false, -- Always show gitignored files
          timeout = 400,
        },
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")
          api.config.mappings.default_on_attach(bufnr)
          vim.keymap.set("n", "v", api.node.open.vertical, {
            desc = "nvim-tree: Open in vertical split",
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          })
        end,
      })
    end,
  },

  ------------------------------------------------------------------
  -- LSP, LINTING, AND FORMATTING
  ------------------------------------------------------------------
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "rust_analyzer", "clangd", "tsserver", "pyright",
          "eslint", "html", "cssls", "tailwindcss", "jsonls", "yamlls",
          "lua_ls", "bashls", "dockerls", "marksman", "taplo", "cmake",
          "omnisharp", "glsl_analyzer"
        },
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier.with({
            filetypes = {
              "javascript", "typescript", "javascriptreact", "typescriptreact",
              "json", "html", "css", "scss", "markdown", "yaml", "glsl"
            },
          }),
          null_ls.builtins.formatting.eslint_d.with({
            condition = function(utils)
              return utils.root_has_file({
                ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json", "package.json", "turbo.json"
              })
            end,
          }),
          null_ls.builtins.code_actions.eslint_d,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.rustfmt,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.yamlfmt,
          null_ls.builtins.formatting.cmake_format,
          null_ls.builtins.diagnostics.eslint.with({
            condition = function(utils)
              return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" })
            end,
          }),
          null_ls.builtins.diagnostics.yamllint,
          null_ls.builtins.diagnostics.cmake_lint,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local util = require("lspconfig.util") -- You might need this for tailwindcss

      -- Omnisharp (C#) Configuration from the reference snippet
      lspconfig.omnisharp.setup({
        capabilities = capabilities,
        cmd = {
          os.getenv("HOME") .. "/.local/share/lvim/mason/packages/omnisharp/libexec/OmniSharp",
          "--languageserver",
          "--hostPID",
          tostring(vim.fn.getpid()),
        },
        init_options = {
          RoslynExtensionsOptions = {
            enableImportCompletion = true,
            enableRoslynAnalyzers = true,
          },
        },
        settings = {
          FormattingOptions = {
            EnableEditorConfigSupport = true,
            OrganizeImports = true,
          },
          MsBuild = {
            LoadProjectsOnDemand = false,
          },
          RoslynExtensionsOptions = {
            enableImportCompletion = true,
            enableRoslynAnalyzers = true,
            documentationProvider = true,
          },
          Sdk = {
            IncludePrereleases = true,
          },
          enableEditorConfigSupport = true,
          enableMsBuildLoadProjectsOnDemand = false,
          enableRoslynAnalyzers = true,
          organizeImportsOnFormat = true,
          enableImportCompletion = true,
          includeInlayParameterNameHints = "all",
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
          dotNetCliPaths = { "/usr/local/share/dotnet/dotnet" },
        },
        on_new_config = function(new_config, new_root_dir)
          if vim.fn.executable("dotnet") == 1 then
            new_config.cmd_env = new_config.cmd_env or {}
            new_config.cmd_env.DOTNET_ROOT = "/usr/local/share/dotnet"
          end
        end,
      })

      -- Your other LSPs
      lspconfig.rust_analyzer.setup({ capabilities = capabilities })
      lspconfig.clangd.setup({
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
          "--compile-commands-dir=build",
          "--pch-storage=memory",
          "--offset-encoding=utf-16",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
        settings = {
          clangd = {
            InlayHints = {
              Designators = true,
              Enabled = true,
              ParameterNames = true,
              DeducedTypes = true,
            },
            fallbackFlags = { "-std=c++23" },
          }
        }
      })
      lspconfig.tsserver.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.eslint.setup({ capabilities = capabilities })
      lspconfig.html.setup({ capabilities = capabilities })
      lspconfig.cssls.setup({ capabilities = capabilities })
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        root_dir = util.root_pattern(
          "tailwind.config.js", "tailwind.config.cjs", "postcss.config.js", "package.json"
        )
      })
      lspconfig.jsonls.setup({
        capabilities = capabilities,
        settings = { json = { schemas = require("schemastore").json.schemas() } },
      })
      lspconfig.yamlls.setup({
        capabilities = capabilities,
        settings = { yaml = { schemas = require("schemastore").yaml.schemas() } },
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })
      lspconfig.bashls.setup({ capabilities = capabilities })
      lspconfig.dockerls.setup({ capabilities = capabilities })
      lspconfig.marksman.setup({ capabilities = capabilities })
      lspconfig.taplo.setup({ capabilities = capabilities })
      lspconfig.cmake.setup({ capabilities = capabilities })
      lspconfig.glsl_analyzer.setup({ capabilities = capabilities })

      -- Assembly Language Server (x86, x86_64, AVR, ARM)
      lspconfig.asm_lsp.setup({
        capabilities = capabilities,
        filetypes = { "asm", "vmasm" },
      })

      -- Auto hover on cursor hold
      vim.o.updatetime = 500
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          local clients = vim.lsp.get_active_clients()
          if #clients > 0 then
            vim.lsp.buf.hover()
          end
        end,
      })
    end,
  },

  ------------------------------------------------------------------
  -- COMPLETION ENGINE
  ------------------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
  { "saadparwaiz1/cmp_luasnip" },

  ------------------------------------------------------------------
  -- TREESITTER (SYNTAX HIGHLIGHTING AND MORE)
  ------------------------------------------------------------------
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "html", "css", "javascript", "typescript", "tsx", "json", "yaml", "toml",
          "c", "cpp", "rust", "python", "lua", "bash", "markdown",
          "markdown_inline", "dockerfile", "cmake", "make", "vim", "vimdoc", "sql", "regex", "glsl",
          "asm"
        },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  },

  ------------------------------------------------------------------
  -- OTHER TOOLS
  ------------------------------------------------------------------
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("cmake-tools").setup({
        cmake_command = "cmake",
        cmake_regenerate_on_save = true,
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
        cmake_build_options = {},
        cmake_build_directory = "build/${variant:buildType}",
        cmake_soft_link_compile_commands = true,
        cmake_compile_commands_from_lsp = false,
        cmake_kits_path = nil,
        cmake_variants_message = {
          short = { show = true },
          long = { show = true, max_length = 40 }
        },
        cmake_dap_configuration = {
          name = "cpp",
          type = "codelldb",
          request = "launch",
          stopOnEntry = false,
          runInTerminal = true,
          console = "integratedTerminal",
        },
        cmake_executor = {
          name = "quickfix",
          opts = {},
          default_opts = {
            quickfix = {
              show = "always",
              position = "belowright",
              size = 10,
              encoding = "utf-8",
              auto_close_when_success = true,
            },
          }
        },
        cmake_runner = {
          name = "terminal",
          opts = {},
          default_opts = {
            quickfix = {
              show = "always",
              position = "belowright",
              size = 10,
              encoding = "utf-8",
              auto_close_when_success = true,
            },
            terminal = {
              name = "Main Terminal",
              prefix_name = "[CMakeTools]: ",
              split_direction = "horizontal",
              split_size = 11,
            }
          }
        }
      })
    end,
  },
  {
    "LhKipp/nvim-nu",
    ft = "nu",
    config = function()
      require("nu").setup()
    end,
  },
}
