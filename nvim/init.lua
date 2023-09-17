require('plugins')
require('airline')
require('nerdtree')
require('lsp')

local set = vim.opt
local setg = vim.g

-- colorscheme
require('gruvbox').setup({
    contrast = "hard"
})
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

set.encoding = "utf-8"

set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true
set.smartindent = true
set.smarttab = true

vim.cmd('let delimitMate_expand_cr = 1')

set.mouse = "a"

-- "hybrid" line numbers
set.number = true
set.relativenumber = true

set.splitright = true
set.splitbelow = true

vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]])
vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]])
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]])
vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]])
vim.keymap.set('n', '<C-h>', [[<C-w>h]], {noremap = false})
vim.keymap.set('n', '<C-j>', [[<C-w>j]], {noremap = false})
vim.keymap.set('n', '<C-k>', [[<C-w>k]], {noremap = false})
vim.keymap.set('n', '<C-l>', [[<C-w>l]], {noremap = false})

set.backupdir="~/vimtmp//,."
set.directory="~/vimtmp//,."

set.completeopt = {'menuone', 'noselect', 'noinsert'}
set.shortmess = set.shortmess + { c = true }
vim.api.nvim_set_option('updatetime', 300)


local cmp = require("cmp")
cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },

  -- Installed sources
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "path" },
    { name = "buffer" },
  },
})

-- Treesitter Plugin Setup 
require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "toml" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false,
  },
  indent = { enable = true }, 
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}
