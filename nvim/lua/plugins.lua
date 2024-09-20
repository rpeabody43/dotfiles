local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    

    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        config = function()
            require("fidget").setup()
        end
    },

    'hrsh7th/nvim-cmp' ,

    'hrsh7th/cmp-nvim-lsp',


    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-vsnip',                   
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/vim-vsnip',

    'neovim/nvim-lspconfig',
    'simrat39/rust-tools.nvim',

    {
        'kevinhwang91/nvim-ufo', 
        dependencies = 'kevinhwang91/promise-async',
        init = function()
            vim.o.foldcolumn = '1' -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return {'treesitter', 'indent'}
                end
            })
        end
    },

    {
        'nvim-treesitter/nvim-treesitter', --syntax highlighting
        build = ':TSUpdate'
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        init = function ()
            require('neo-tree').setup({
                window = {
                    width = 25
                }
            })
        end
    },
    'ellisonleao/gruvbox.nvim', --gruvbox theme
    'airblade/vim-gitgutter', --show git changes in file
    'alvan/vim-closetag', --autoclose html tags
    'norcalli/nvim-colorizer.lua', --syntax highlighting
    'tiagofumo/vim-nerdtree-syntax-highlight', --file eplorer highlighting
    'nvim-lua/plenary.nvim', --unsure what this does but seems important
    'christoomey/vim-tmux-navigator', --easy navigation between panes
    'bling/vim-airline', --nice status bar at bottom
    'vim-airline/vim-airline-themes', --themes for said nice status bar at bottom
    'windwp/nvim-autopairs', --close brackets, parentheses, etc.
    'windwp/nvim-ts-autotag',
    {
        'ryanoasis/vim-devicons', --icons for nerdtree and airline
        dependencies = {"vim-airline"}
    },
}

require("lazy").setup(plugins, {})
