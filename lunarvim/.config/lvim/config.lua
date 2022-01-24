--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- original: ~/.local/share/lunarvim/lvim/utils/installer/config.example.lua
-- If lots of errors after reinstall, exucute:
-- :LvimCacheReset and :PackerSync

-- general
-- vim.opt.shell = "/bin/bash"
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.transparent_window = true
lvim.colorscheme = "default"
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.options.theme = "onedark"
lvim.builtin.lualine.sections.lualine_c = { "filename", "diagnostics" }
vim.cmd([[
" FIXME: whitespace is not highlighted
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:$,space:·,conceal:·
set nowrapscan
" wrap long lines, hard break long line using `gq`
set wrap
" this updatetime affects the CursorHold
set updatetime=1000
]])

-- Additional Plugins
lvim.plugins = {
	--     {"folke/tokyonight.nvim"},
	--     {
	--       "folke/trouble.nvim",
	--       cmd = "TroubleToggle",
	--     },
	{ "szw/vim-maximizer" },
	{ "chrisbra/Colorizer" },
	{ "vimlab/split-term.vim" },
	{ "thinca/vim-quickrun" },
	{ "ethanholz/nvim-lastplace" },
	{ "phaazon/hop.nvim" },
	{ "https://gitlab.com/yorickpeterse/nvim-window.git" },
}

require("telescope").setup({
	pickers = {
		find_files = {
			hidden = true,
			theme = "ivy",
			path_display = { nil },
		},
	},
})

-- from ethanholz/nvim-lastplace
require("nvim-lastplace").setup({
	lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
	lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
	lastplace_open_folds = true,
})
-- from phaazon/hop.nvim
require("hop").setup()
-- https://gitlab.com/yorickpeterse/nvim-window.git
require("nvim-window").setup({
	-- The characters available for hinting windows.
	chars = {
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
	},
	-- A group to use for overwriting the Normal highlight group in the floating
	-- window. This can be used to change the background color.
	normal_hl = "Normal",
	-- The highlight group to apply to the line that contains the hint characters.
	-- This is used to make them stand out more.
	hint_hl = "Bold",
	-- The border style to use for the floating window.
	border = "single",
})

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
lvim.keys.normal_mode["q"] = ":q<cr>"
lvim.keys.normal_mode["Q"] = ":qa!<cr>"
lvim.keys.normal_mode["<C-a>"] = "<Home>"
lvim.keys.insert_mode["<C-a>"] = "<Home>"
lvim.keys.normal_mode["<C-e>"] = "<End>"
lvim.keys.insert_mode["<C-e>"] = "<End>"
-- delete the next character in insert mode
lvim.keys.insert_mode["<C-d>"] = "<Delete>"
-- delete text to the end of line
lvim.keys.insert_mode["<C-k>"] = "<c-o>d$"
-- reselect last marked text
lvim.keys.normal_mode["<C-x><C-x>"] = "gv"
-- switch to previous buffer
lvim.keys.normal_mode["<C-x>x"] = ":b#<CR>"
-- format buffer, or using rough one: "gg=G``"
lvim.keys.normal_mode["=="] = "<cmd>lua vim.lsp.buf.formatting()<cr>"
-- git related, more in <Leader>g
lvim.keys.normal_mode["[h"] = "<cmd>lua require 'gitsigns'.prev_hunk()<cr>"
lvim.keys.normal_mode["]h"] = "<cmd>lua require 'gitsigns'.next_hunk()<cr>"
lvim.keys.normal_mode["[d"] = "<cmd>lua require 'gitsigns'.preview_hunk()<cr>"
lvim.keys.normal_mode["[a"] = "<cmd>lua require 'gitsigns'.stage_hunk()<cr>"
lvim.keys.normal_mode["[u"] = "<cmd>lua require 'gitsigns'.reset_hunk()<cr>"
lvim.keys.normal_mode["[U"] = "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>"
-- move lines up and down
-- copy and modified from ~/.local/share/lunarvim/lvim/lua/lvim/keymappings.lua
-- the default are Alt-j/k
vim.api.nvim_set_keymap("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-Down>", ":m '>+1<CR>gv-gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-Up>", ":m '<-2<CR>gv-gv", { noremap = true, silent = true })
-- FIXME: not work, move lines with M-Up/Down/Left/Right
-- lvim.keys.normal_mode["<A-Down>"] = "<A-j>"
-- lvim.keys.normal_mode["<A-Up>"] = "<A-k>"
-- lvim.keys.normal_mode["<A-Left>"] = "<A-h>"
-- lvim.keys.normal_mode["<A-Right>"] = "<A-l>"
-- lvim.keys.insert_mode["<A-Down>"] = "<A-j>"
-- lvim.keys.insert_mode["<A-Up>"] = "<A-k>"
-- lvim.keys.insert_mode["<A-Left>"] = "<A-h>"
-- lvim.keys.insert_mode["<A-Right>"] = "<A-l>"
-- the following binding is from vim-maximizer
lvim.keys.normal_mode["<C-w>m"] = ":MaximizerToggle<cr>"
lvim.keys.normal_mode["<C-w>1"] = ":only<cr>"

lvim.autocommands.custom_groups = {
	-- On entering a lua file, set the tab spacing and shift width to 8
	{ "BufWinEnter", "*.lua", "set noexpandtab ts=2 sw=2" },
	{ "BufRead,BufNewFile", "*.c,*.h", "set noexpandtab tabstop=8 shiftwidth=8" },
	{ "BufRead,BufNewFile", "*.cpp,*.cc,*.hpp", "set noexpandtab tabstop=4 shiftwidth=4" },
	-- auto hover when cursot is stopped at something
	-- hover can maually triggered by K
	-- * if &filetype != "latex" && &filetype != "plaintex" | do
	{ "CursorHold,CursorHoldI,MenuPopup", '* if &ft != "fish" | lua vim.lsp.buf.hover()' },
	-- On entering insert mode in any file, scroll the window so the cursor line is centered
	-- { "InsertEnter", "*", ":normal zz" },
	{ "FileType", "gitcommit 1 | startinsert" },
	-- for color and borders of pop windows likes which-key and completion
	{ "ColorScheme * highlight Pmenu ctermbg=NONE guibg=NONE" },
	{ "ColorScheme * highlight FloatBorder ctermbg=NONE guibg=NONE" },
}

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Bindings:
-- get all the bindings using:
-- `lvim --headless +'lua require("lvim.utils").generate_settings()' +qa && sort -o lv-settings.lua{,}`
-- Use which-key to add extra bindings with the leader-key prefix
-- from vimlab/split-term.vim
lvim.builtin.which_key.mappings["'"] = { "<Esc><Cmd>ToggleTerm<CR>", "Quick Terminal" }
lvim.builtin.which_key.mappings["vv"] = { ":VTerm<CR>", "V Term" }
lvim.builtin.which_key.mappings["vs"] = { ":Term<CR>", "H Term" }
lvim.builtin.which_key.mappings["b<Space>"] = { "<cmd>Telescope buffers<cr>", "Switch Buffers" }
lvim.builtin.which_key.mappings["xx"] = { ":QuickRun<CR>", "QuickRun" }
lvim.builtin.which_key.mappings["ss"] = { ":Telescope current_buffer_fuzzy_find fuzzy=false<CR>", "Search Buffer" }
-- original / is to comment
lvim.builtin.which_key.mappings["/"] = { ":Telescope current_buffer_fuzzy_find fuzzy=false<CR>", "Search Buffer" }
lvim.builtin.which_key.mappings["sP"] = { "<cmd>Telescope live_grep<CR>", "Live Search" }
lvim.builtin.which_key.mappings["l/"] = { ":Telescope lsp_document_symbols<CR>", "Document Symbols" }
lvim.builtin.which_key.mappings["l."] = { ":Telescope lsp_workspace_symbols<CR>", "Workspace Symbols" }

lvim.builtin.which_key.mappings["t"] = {
	name = "+Toggle",
	-- from chrisbra/Colorizer
	c = { ":ColorToggle<CR>", "Toggle Color" },
	w = { ":set list!<CR>", "Toggle Whitespace" },
	l = { ":set wrap!", "Wrap Lines" },
}
lvim.builtin.which_key.mappings["p"] = {
	name = "+Projects",
	p = { "<cmd>Telescope projects<CR>", "Switch Projects" },
	f = { "<cmd>Telescope find_files<CR>", "Find Files" },
	-- FIXME: ignore untracked files/dirs
	g = { "<cmd>Telescope git_files<CR>", "Git Files" },
	b = { "<cmd>Telescope buffers<CR>", "Buffers" },
	s = { "<cmd>Telescope live_grep<CR>", "Live Search" },
	h = { "<cmd>Telescope help_tags<CR>", "Help Tags" },
	["/"] = { "<cmd>Telescope lsp_document_symbols<CR>", "Buffer Symbols" },
	["."] = { "<cmd>Telescope lsp_workspace_symbols<CR>", "Woskapce Symbols" },
}
lvim.builtin.which_key.mappings["h"] = {
	name = "+Help",
	-- from thinca/vim-quickrun
	h = { "<cmd>Telescope<CR>", "Telescope" },
	c = { "<cmd>Telescope commands<CR>", "Commands" },
	m = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
	M = { "<cmd>Telescope marks<CR>", "Marks" },
	v = { "<cmd>Telescope vim_options<CR>", "Variables" },
	s = { "<cmd>Telescope spell_suggest<CR>", "Spell Suggest" },
	b = { "<cmd>Telescope keymaps<CR>", "Keybindings" },
	H = { "<cmd>Telescope highlights<CR>", "Higlights" },
}
-- rewrite them under P, original is p
lvim.builtin.which_key.mappings["P"] = {
	name = "+Packer",
	c = { "<cmd>PackerCompile<cr>", "Compile" },
	i = { "<cmd>PackerInstall<cr>", "Install" },
	r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
	s = { "<cmd>PackerSync<cr>", "Sync" },
	S = { "<cmd>PackerStatus<cr>", "Status" },
	u = { "<cmd>PackerUpdate<cr>", "Update" },
}
lvim.builtin.which_key.mappings["f"] = {
	name = "+Files",
	f = { "<cmd>Telescope find_files<CR>", "Find Files" },
	r = { "<cmd>Telescope oldfiles<CR>", "Recent Files" },
}
-- more windows operations in <C-w>
lvim.builtin.which_key.mappings["w"] = {
	name = "+Windows",
	d = { "<C-w>q", "Delete Window" },
	q = { "<C-w>q", "Delete Window" },
	["1"] = { ":only<CR>", "Delete Other Windows" },
	["-"] = { "<C-w>s", "Split Window" },
	["\\"] = { "<C-w>v", "Split Window V" },
	w = { "<C-w>w", "Switch Windows" },
	-- the following binding is from vim-maximizer
	m = { ":MaximizerToggle<cr>", "Max Window" },
	-- from https://gitlab.com/yorickpeterse/nvim-window.git
	a = { ":lua require('nvim-window').pick()<CR>", "Choose Windows" },
}
lvim.builtin.which_key.mappings["j"] = {
	name = "+Jump",
	w = { ":HopWord<CR>", "Jump Word" },
	l = { ":HopLine<CR>", "Jump Line" },
	j = { ":HopChar2<CR>", "Jump Chars" },
}
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"fish",
	"c",
	"cpp",
	"cmake",
	"make",
	"ninja",
	"rust",
	"python",
	"lua",
	"vim",
	-- "emacs-lisp",
	"toml",
	"yaml",
	"json",
	"javascript",
	"typescript",
	"css",
	"java",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "stylua", filetypes = { "lua" } },
	{ command = "fish_indent", filetypes = { "fish" } },
	{ command = "shfmt", filetypes = { "sh" } },
	--   { command = "black", filetypes = { "python" } },
	--   { command = "isort", filetypes = { "python" } },
	--   {
	--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
	--     command = "prettier",
	--     ---@usage arguments to pass to the formatter
	--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
	--     extra_args = { "--print-with", "100" },
	--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
	--     filetypes = { "typescript", "typescriptreact" },
	--   },
})

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
