-- use .vimrc as a base file
vim.cmd("source ~/.vimrc")

-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- init lazy
require("lazy").setup({
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
    opts = {},
  },
  "tpope/vim-commentary",
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "-" },
        topdelete    = { text = "^-" },
        changedelete = { text = "_" },
        untracked    = { text = "┆" },
      },
      preview_config = { border = "rounded" }
    }
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    event = "BufEnter",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end
      },
      {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
          require("telescope").load_extension("ui-select")
        end
      },
    },
    config = function()
      actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { ".git/.*", "renv/.*", "venv/.*" },
          layout_strategy = "flex",
          layout_config = {
            horizontal = { preview_cutoff = 0, width = 0.90, height = 0.85 },
            vertical = { preview_cutoff = 0, width = 0.90 },
          },
          hidden = true,
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<Esc>"] = actions.close,
              ["<C-j>"] = { actions.move_selection_previous, type = "action" },
              ["<C-k>"] = { actions.move_selection_next, type = "action" }
            }
          },
        },
        pickers = {
          find_files = {
            hidden = true
          }
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          ["ui-select"] = {
            require("telescope.themes").get_cursor()
          }
        }
      })
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    config = function()
      vim.opt.list = true
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.keymap.set('n', '<C-b>', '<Cmd>Neotree toggle<CR>')
    end
  },
  {
    "echasnovski/mini.pairs",
    version = false,
    config = function()
      require("mini.pairs").setup()
    end
  },
  {
    "echasnovski/mini.trailspace",
    version = false,
    config = function()
      require("mini.trailspace").setup()
      -- Delete trailing whitespace on save
      vim.api.nvim_create_autocmd("BufWritePre", { command = "lua MiniTrailspace.trim()" })
    end
  },
  {
    "echasnovski/mini.surround",
    version = "*",
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add = 'Sa', -- Add surrounding in Normal and Visual modes
        delete = 'Sx', -- Delete surrounding
        find = 'Sf', -- Find surrounding (to the right)
        find_left = '', -- Find surrounding (to the left)
        highlight = 'Sh', -- Highlight surrounding
        replace = 'Sr', -- Replace surrounding
        update_n_lines = 'Sn', -- Update `n_lines`
        suffix_last = '', -- Suffix to search with "prev" method
        suffix_next = '', -- Suffix to search with "next" method
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "query",
          "rust", "c", "cpp", "go",
          "r", "python", "julia",
          "javascript", "html", "typescript",
          "toml", "yaml", "json",
          "bash", "awk", "jq",
          "markdown", "markdown_inline",
          "gitcommit", "gitignore", "gitattributes",
          "dockerfile", "sql", "comment"
        },
        auto_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "markdown" }
        },
        ident = { enable = true },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>v",
            node_incremental = "<leader><CR>",
            node_decremental = "<leader><BS>"
          }
        },
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { "BufWrite", "CursorHold" },
        }
      })

      --Replace indent folding with treesitter folding
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false
    end
  },
  {
    "neovim/nvim-lspconfig",
    ft = { "r", "rmd", "quarto", "python", "html", "css" },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({ default_timeout = 20000 })
      null_ls.register({
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.formatting.shfmt.with({
          extra_args = { "-i", "4", "-bn", "-sr", "-p", "-ci" }
        })
      })
      null_ls.register({
        null_ls.builtins.diagnostics.sqlfluff,
        null_ls.builtins.formatting.sqlfluff
      })
      null_ls.register({
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.autopep8,
        null_ls.builtins.formatting.styler,
        null_ls.builtins.formatting.jq
      })
    end
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build = "make install_jsregexp",
        dependencies = {
          "rafamadriz/friendly-snippets",
          "saadparwaiz1/cmp_luasnip"
        }
      },
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc"
    },

    config = function()
      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
      end

      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        })
      })

      cmp.setup({
        enabled = function()
          local context = require 'cmp.config.context'
          if vim.api.nvim_get_mode().mode == 'c' then
            return true
          else
            return not context.in_treesitter_capture("comment")
              and not context.in_syntax_group("Comment")
          end
        end,
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-p>"] = cmp.mapping.scroll_docs(-4),
          ["<C-n>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end
          })
        },
        sources = {
          { name = "path",       max_item_count = 4},
          { name = "nvim_lsp",   max_item_count = 9, keyword_length = 1 },
          { name = "buffer",     max_item_count = 9, keyword_length = 2 },
          { name = "copilot",    max_item_count = 4 },
          { name = "luasnip",    max_item_count = 4 },
          { name = "nvim_lsp_signature_help" },
          { name = "calc" },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })

      -- Toggle autocompletion
      vim.g.cmp_toggle_flag = true
      function toggleAutoCmp()
        local next_cmp_toggle_flag = not vim.g.cmp_toggle_flag
        if next_cmp_toggle_flag then
          print("Completion on")
        else
          print("Completion off")
        end
        if next_cmp_toggle_flag then
          cmp.setup({
            completion = {
              autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged }
            }
          })
          vim.g.cmp_toggle_flag = next_cmp_toggle_flag
        else
          cmp.setup({
            completion = {
              autocomplete = false
            }
          })
          vim.g.cmp_toggle_flag = next_cmp_toggle_flag
        end
      end

      -- Autocomplete mappings
      vim.keymap.set('n', 'gd', "<cmd>lua vim.lsp.buf.definition()<cr>", {})
    end
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" }
    },
    config = function()
      require("mason").setup()
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = { "lua_ls", "pyright", "html", "cssls", "sqlls" }
      })
      mason_lspconfig.setup_handlers {
        function (server_name) -- default handler
            require("lspconfig")[server_name].setup {}
        end,
      }
    end,
  },
})
