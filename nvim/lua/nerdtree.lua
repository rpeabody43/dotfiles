-- Automatically close nvim if NERDTree is only thing left open
vim.cmd([[
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " Toggle
    nnoremap <silent> <C-b> :NERDTreeToggle<CR>
]])

vim.cmd("let NERDTreeMinimalUI=1")
