require('plugins')
require('config')

local set = vim.opt
local setg = vim.g

-- colorscheme
vim.o.background = "dark"
require('gruvbox').setup({
   contrast = "hard"
})
vim.cmd([[colorscheme gruvbox]])

set.encoding = "utf-8"

set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true
set.smartindent = true
set.smarttab = true
set.colorcolumn = "81";


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

vim.cmd([[
    nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
    nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
]])

-- disable arrow keys
for _, mode in pairs({ 'n', 'v', 'x' }) do
    for _, key in pairs({ '<Up>', '<Down>', '<Left>', '<Right>' }) do
        vim.keymap.set(mode, key, '<nop>')
    end
end


set.backupdir="~/vimtmp//,."
set.directory="~/vimtmp//,."

set.completeopt = {'menuone', 'noselect', 'noinsert'}
set.shortmess = set.shortmess + { c = true }
vim.api.nvim_set_option_value('updatetime', 300, {})
