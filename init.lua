-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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
    -- Neovim setup for init.lua and plugin development
    'folke/neodev.nvim',
    config = function()
      require('neodev').setup()
    end
  },

  {
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
    opts = {},
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
    -- Catppuccin theme
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'macchiato',
      })
      vim.cmd.colorscheme('catppuccin')
    end
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
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  {
    -- "gc" to comment visual regions
    'numToStr/Comment.nvim',
    opts = {},
  },

  {
    -- Add terminal
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup {
        open_mapping = '<C-t>',
        direction = 'float',
        float_opts = {
          border = 'curved',
        },
      }
    end,
  },
})

-- Make line numbers default
vim.wo.number = true

-- Enable break indent
vim.o.breakindent = true

vim.o.termguicolors = true

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

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
