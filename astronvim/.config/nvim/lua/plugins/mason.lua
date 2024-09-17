-- Customize Mason plugins
-- :Mason to check the installed and available sources

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "lua_ls",
        -- add more arguments for adding more language servers
        "rust_analyzer",
        -- "bashls",
        "clangd",
        "neocmake",
        -- "gopls",
        "pyright",
        -- TODO: https://github.com/neovim/nvim-lspconfig/commit/6dfb2463e3351359fe6d6a902ac06857b3d7ed20
        -- "fish",
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "stylua",
        -- add more arguments for adding more null-ls sources
        "clang-format",
        "shfmt",
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = {
        "python",
        -- add more arguments for adding more debuggers
        "codelldb",
      },
    },
  },
}
