-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable break indent
vim.o.breakindent = true

vim.o.termguicolors = true

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
vim.keymap.set('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Open file explorer
vim.keymap.set('n', '<leader>fe', vim.cmd.Ex)

-- Install Lazy package manager
local lazy_path = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazy_path,
  }
end
vim.opt.rtp:prepend(lazy_path)

require('lazy').setup({
  {
    -- Catppuccin theme
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha',
      })
      vim.cmd.colorscheme('catppuccin')
    end
  },

  {
    -- Telescope for file search
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    end
  },

  {
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
  },

  {
    -- Useful plugin to show you pending keybinds
    'folke/which-key.nvim',
    opts = {},
  },

  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'catppuccin',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
    config = function()
      require('ibl').setup()
    end
  },

  {
    -- "gc" to comment visual regions
    'numToStr/Comment.nvim',
  },

  {
    -- Toggle terminal
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup({
        open_mapping = '<C-t>',
        direction = 'float',
        float_opts = {
          border = 'single',
        },
        -- Locally change the path to shell when necessary.
        -- It assumes Windows 11 with w64devkit by default.
        shell = 'C:\\w64devkit\\w64devkit.exe',
      })
    end
  }
})

