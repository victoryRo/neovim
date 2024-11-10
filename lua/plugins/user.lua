
-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  -- ================================ Adding Themes =================================
  --NOTE: description themes

  {
    "rmehri01/onenord.nvim",
  },

  {
    "kaiuri/nvim-juliana",
    lazy = false,
    opts = { --[=[ configuration --]=]
    },
    config = true,
  },

  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup {
        -- Your config here
      }
    end,
  },

  ------------------------------------------

  { "projekt0n/github-nvim-theme" },

  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
    config = function()
      require("ayu").setup {
        mirage = true,
        terminal = true,
        -- overrides = {
        --   Normal = { bg = "None" },
        --   ColorColumn = { bg = "None" },
        --   SignColumn = { bg = "None" },
        --   Folded = { bg = "None" },
        --   FoldColumn = { bg = "None" },
        --   CursorLine = { bg = "None" },
        --   CursorColumn = { bg = "None" },
        --   WhichKeyFloat = { bg = "None" },
        --   VertSplit = { bg = "None" },
        -- },
      }
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        background = { -- :h background
          light = "latte",
          -- dark = "frappe",
          dark = "macchiato",
        },
        transparent_background = false, -- disables setting the background color.
      }
    end,
  },

-- ================================ Adding Plugins ================================

  ---- presence
  "andweeb/presence.nvim",

  ---- color brackets
  { "HiPhish/rainbow-delimiters.nvim" },

  ---- signature help
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  ---- live server
  {
    "ngtuonghy/live-server-nvim",
    event = "VeryLazy",
    build = ":LiveServerInstall",
    config = function()
      local srv = require "live-server-nvim"
      srv.setup {
        custom = {
          "--port=8080",
          "--no-css-inject",
        },
        serverPath = vim.fn.stdpath "data" .. "/live-server/", --default
        open = "folder", -- folder|cwd     --default
      }
    end,
  },

  ---- minimap ...
  {
    "gorbit99/codewindow.nvim",
    config = function()
      local codewindow = require "codewindow"
      codewindow.setup {
        exclude_filetypes = { "help" }, -- Choose certain filetypes to not show minimap on
        minimap_width = 10, -- The width of the text part of the minimap
        width_multiplier = 4, -- How many characters one dot represents
        window_border = "single", -- The border style of the floating window (accepts all usual options)
        events = { "TextChanged", "InsertLeave", "DiagnosticChanged", "FileWritePost" }, -- Events that update the code window
      }
      codewindow.apply_default_keybinds()
    end,
  },

  ---- go binaries
  {
    {
      "crispgm/nvim-go",
      event = "User AstroFile",
      config = function()
        require("go").setup {
          notify = true,
          -- auto commands
          auto_format = true,
          auto_lint = true,
          -- linters: revive, errcheck, staticcheck, golangci-lint
          linter = "golangci-lint",
          -- lint_prompt_style: qf (quickfix), vt (virtual text)
          lint_prompt_style = "qf",
        }
      end,
      cmd = { "GoInstallBinaries", "GoUpdateBinaries", "GoTest" },
    },
  },

  ---- lsp show pupup window
  {
    "rmagatti/goto-preview",
    event = "User AstroFile",
    config = function()
      require("goto-preview").setup {
        width = 120, -- Width of the floating window
        height = 15, -- Height of the floating window
        border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
        default_mappings = true, -- Bind default mappings
        debug = false, -- Print debug information
        opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
        resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
        post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        post_close_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        references = { -- Configure the telescope UI for slowing the references cycling window.
          telescope = require("telescope.themes").get_dropdown { hide_preview = false },
        },
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        focus_on_open = true, -- Focus the floating window when opening it.
        dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
        force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
        stack_floating_preview_windows = true, -- Whether to nest floating windows
        preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
      }
    end,
  },

  ---- indent line
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup {
        chunk = {
          enable = true,
          use_treesitter = true,
          style = {
            { fg = "#669999" },
            { fg = "#c21f30" },
          },
        },
        indent = {
          enable = true,
          use_treesitter = false,
          style = {
            { fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID "Whitespace"), "fg", "gui") },
          },
        },
        line_num = {
          enable = false,
          use_treesitter = false,
        },
        blank = {
          enable = false,
        },
      }
    end,
  },

  ---- Codeium autocompletion
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    config = function ()
      vim.g.codeium_disable_bindings = 1
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    end
  },

  -- ================================================================================

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  -- ============================ Disable default plugins ===========================

  -- enable escape (jk)
  { "max397574/better-escape.nvim", enabled = true },

  -- disable indent line
  { "lukas-reineke/indent-blankline.nvim", enabled = false },

  -- disable comments
  { "numToStr/Comment.nvim", enabled = false },


  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
