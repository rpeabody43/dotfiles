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
        'nvim-treesitter/nvim-treesitter', -- syntax highlighting
        build = ':TSUpdate'
    },

    {
        "nvim-neo-tree/neo-tree.nvim", -- file selector
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

    {
        "yetone/avante.nvim", -- AI integration
        build = vim.fn.has("win32") ~= 0
            and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
            or "make",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        opts = {
            -- add any opts here
            -- this file can contain specific instructions for your project
            instructions_file = "avante.md",
            -- for example
            provider = "copilot",
            mode = "legacy", -- prevent the agent from doing things on its own
            input = {
                provider = "snacks",
                provider_opts = {
                    -- Additional snacks.input options
                    title = "Avante Input",
                    icon = " ",
                },
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua", -- for copilot
            "folke/snacks.nvim", -- for input provider snacks
        },
    },

    'ellisonleao/gruvbox.nvim',                 -- gruvbox theme
    'sekke276/dark_flat.nvim',                  -- dark flat theme
    'airblade/vim-gitgutter',                   -- show git changes in file
    'alvan/vim-closetag',                       -- autoclose html tags
    'norcalli/nvim-colorizer.lua',              -- syntax highlighting
    'tiagofumo/vim-nerdtree-syntax-highlight',  -- file explorer highlighting
    'nvim-lua/plenary.nvim',                    -- unsure what this does but seems important
    'christoomey/vim-tmux-navigator',           -- easy navigation between panes
    'bling/vim-airline',                        -- nice status bar at bottom
    'vim-airline/vim-airline-themes',           -- themes for said nice status bar at bottom
    'windwp/nvim-autopairs',                    -- close brackets, parentheses, etc.
    'windwp/nvim-ts-autotag',
    {
        'ryanoasis/vim-devicons',               -- icons for nerdtree and airline
        dependencies = {"vim-airline"}
    },
    'chrisgrieser/nvim-lsp-endhints',            -- show inlay hints after the line
    {
        "zbirenbaum/copilot.lua",                    -- github copilot
        dependencies = {"copilotlsp-nvim/copilot-lsp"}
    },
}

require("lazy").setup(plugins, {})
