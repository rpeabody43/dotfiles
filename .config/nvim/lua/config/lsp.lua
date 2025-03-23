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
require("mason-lspconfig").setup()


-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

-- fmt on save
vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

local function on_attach(client, buffer)
    -- callback function for when rust lsp is attached
end


local rust_tools_opts = {
  tools = {
    runnables = {
      use_telescope = false,
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = on_attach,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}

require("rust-tools").setup(rust_tools_opts)
local lspconfig = require("lspconfig")
-- below basic rust config is commented out because it has bad inlay hints
-- lspconfig.rust_analyzer.setup({
--     on_attach = function(client, bufnr)
--       vim.lsp.inlay_hint.enable()
--     end
-- })
lspconfig.pyright.setup{}
lspconfig.clangd.setup{
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto","hpp"},
}
lspconfig.ts_ls.setup{}
lspconfig.svelte.setup{}
lspconfig.ocamllsp.setup{}

lspconfig.gopls.setup{}

require("nvim-autopairs").setup{}
require('nvim-ts-autotag').setup()

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})


vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})
