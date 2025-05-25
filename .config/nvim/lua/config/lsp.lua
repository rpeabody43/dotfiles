-- This file is a mess but it works

-- Mason Setup
require("mason").setup({
    ensure_installed = {
        "rust-analyzer",
        "codelldb",
        "pyright",
        "clangd",
        "gopls"
    },
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})
require("mason-lspconfig").setup{}

-- putting inlay hints at end of line
require("lsp-endhints").setup{
    icons = {
        type = "",
        parameter = "",
        offspec = "",
        unknown = ""
    },
    label = {
        padding = 0,
    }
}

-- fmt on save
vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

vim.lsp.config('rust_analyzer', {
    on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable()
    end
})

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                    'vim',
                    'require'
                },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})

vim.lsp.config('clangd', {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "hpp"},
})

require("nvim-autopairs").setup{}
require('nvim-ts-autotag').setup()

vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = true,
        header = '',
        prefix = '',
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
    },
})
