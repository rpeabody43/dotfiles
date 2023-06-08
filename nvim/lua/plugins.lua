return require('packer').startup(function ()
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    
    -- Mason Setup
    require("mason").setup({
        ensure_installed = {
            "rust-analyzer",
            "codelldb"
        },
        ui = {
            icons = {
                package_installed = "",
                package_pending = "",
                package_uninstalled = "",
            },
        }
    })
    require("mason-lspconfig").setup()

    use ({
        "j-hui/fidget.nvim",
        config = function()
          require("fidget").setup()
        end
    })

    use 'hrsh7th/nvim-cmp' 

    use 'hrsh7th/cmp-nvim-lsp'


    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'                             
    use 'hrsh7th/cmp-path'                              
    use 'hrsh7th/cmp-buffer'                            
    use 'hrsh7th/vim-vsnip'   

    use 'neovim/nvim-lspconfig' 
    use 'simrat39/rust-tools.nvim'

    use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}
    use 'nvim-treesitter/nvim-treesitter'
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

    use 'wbthomason/packer.nvim' --packer itself
	use 'scrooloose/nerdtree' --file explorer
	use 'ryanoasis/vim-devicons' --icons for nerdtree
	use 'ellisonleao/gruvbox.nvim' --theme
	use 'airblade/vim-gitgutter' --show git changes in file
	use 'alvan/vim-closetag' --autoclose html tags
	use 'norcalli/nvim-colorizer.lua' --syntax highlighting
	--this plugin causes an error whenever starting nerdtree
	--use 'tiagofumo/vim-nerdtree-syntax-highlight' --file eplorer highlighting
	use 'nvim-lua/plenary.nvim' --unsure what this does but seems important
	use 'christoomey/vim-tmux-navigator' --easy navigation between panes
	use 'bling/vim-airline' --nice status bar at bottom
	use 'vim-airline/vim-airline-themes' --themes for said nice status bar at bottom
	use 'Xuyuanp/nerdtree-git-plugin' --show git changes in file explorer
end)
