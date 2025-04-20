-- Customize Mason
-- `:checkheath mason` and `:Mason` for more info

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",
	"rust-analyzer",
	-- gopls,
	"ruff",
	-- https://github.com/mason-org/mason-registry/pull/8609
	-- fish-lsp

        -- install formatters
        "stylua",
	"clang-format",

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
