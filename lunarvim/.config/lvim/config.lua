--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
-- vim.opt.shiftwidth = 2
-- vim.opt.tabstop = 2
-- vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = true,
	-- pattern only apply format_on_save for the type
	-- pattern = "*.lua",
	timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
-- remove C-l mapping which closes the term (C-\ to toggle the term)
lvim.keys.term_mode = { ["<C-l>"] = false }
lvim.keys.normal_mode["q"] = ":q<cr>"
lvim.keys.normal_mode["Q"] = ":qa!<cr>"
lvim.keys.normal_mode["U"] = "<C-r>"
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
lvim.keys.normal_mode["=<CR>"] = "<cmd>lua vim.lsp.buf.formatting()<cr>"
lvim.keys.normal_mode["=t"] = ":LvimToggleFormatOnSave<cr>"
-- git related, more in <Leader>g
lvim.keys.normal_mode["[h"] =
"<cmd>lua require 'gitsigns'.prev_hunk()<cr><cmd>lua require 'gitsigns'.preview_hunk()<cr>"
lvim.keys.normal_mode["['"] =
"<cmd>lua require 'gitsigns'.prev_hunk()<cr><cmd>lua require 'gitsigns'.preview_hunk()<cr>"
lvim.keys.normal_mode["]h"] =
"<cmd>lua require 'gitsigns'.next_hunk()<cr><cmd>lua require 'gitsigns'.preview_hunk()<cr>"
lvim.keys.normal_mode["]'"] =
"<cmd>lua require 'gitsigns'.next_hunk()<cr><cmd>lua require 'gitsigns'.preview_hunk()<cr>"
lvim.keys.normal_mode["[p"] = "<cmd>lua require 'gitsigns'.preview_hunk()<cr>"
-- [c/]c to the prev/next diff in diffthis window
lvim.keys.normal_mode["[P"] = "<cmd>lua require 'gitsigns'.diffthis()<cr>"
lvim.keys.normal_mode["[a"] = "<cmd>lua require 'gitsigns'.stage_hunk()<cr>"
lvim.keys.normal_mode["[b"] = "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>"
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

-- change default lsp bindings to use trouble lsp functions
-- lvim.lsp.buffer_mappings.normal_mode["g/"] = { ":Telescope lsp_document_symbols<CR>", "Lsp Document Symbols" }
lvim.lsp.buffer_mappings.normal_mode["g/"] = { "<cmd>Lspsaga outline<CR>", "Lsp Symbols" }
lvim.lsp.buffer_mappings.normal_mode["gh"] = { "<cmd>Lspsaga lsp_finder<CR>", "Lsp Symbol Finder" }
lvim.lsp.buffer_mappings.normal_mode["ga"] = { "<cmd>Lspsaga code_action<CR>", "Lsp Code Action" }
lvim.lsp.buffer_mappings.normal_mode["gl"] = { "<Cmd>lua vim.lsp.codelens.run()<CR>", "Lsp CodeLens Actions" }
-- C-c v/i in the peek window to edit the file in split window, C-c o to open it
lvim.lsp.buffer_mappings.normal_mode["gd"] = { "<cmd>Lspsaga peek_definition<CR>", "Lsp Definition Peek" }
lvim.lsp.buffer_mappings.normal_mode["gD"] = { ":vsplit<CR><cmd>Lspsaga goto_definition<CR>", "Lsp Definition Goto" }
lvim.lsp.buffer_mappings.normal_mode["gi"] = { "<cmd>Lspsaga incoming_calls<CR>", "Lsp Incoming Calls" }
lvim.lsp.buffer_mappings.normal_mode["gI"] = { "<cmd>Lspsaga outgoing_calls<CR>", "Lsp Outgoing Calls" }
lvim.lsp.buffer_mappings.normal_mode["gt"] = { "<cmd>Lspsaga peek_type_definition<CR>", "Lsp Type Peek" }
lvim.lsp.buffer_mappings.normal_mode["gT"] = { "<cmd>Lspsaga goto_type_definition<CR>", "Lsp Type Goto" }
-- there are `Lspsaga diagnostic_jump_prev/next` commands
lvim.lsp.buffer_mappings.normal_mode["gL"] = { "<cmd>Lspsaga show_buf_diagnostics<CR>", "Lsp Buffer Diagnostics" }
lvim.lsp.buffer_mappings.normal_mode["gr"] = { "<cmd>Lspsaga rename<CR>", "Lsp Rename" }
lvim.lsp.buffer_mappings.normal_mode["gR"] = { "<cmd>Lspsaga rename ++project<CR>", "Lsp Rename Proj" }
lvim.lsp.buffer_mappings.normal_mode["gS"] = { "<Cmd>Trouble lsp_references<CR>", "Lsp References" }

-- `lvim --headless +'lua require("lvim.utils").generate_settings()' +qa && sort -o lv-settings.lua{,}`
-- Use which-key to add extra bindings with the leader-key prefix
-- from vimlab/split-term.vim
-- NOTE: C-l in the terminal to toggle the terminal back to the editor
-- C-l by default to toggle the terminal
lvim.builtin.which_key.mappings["<Space>"] = { ":lua require('nvim-window').pick()<CR>", "Choose Windows" }
lvim.builtin.which_key.mappings["'"] = { ":ToggleTerm<CR>", "Toggle Terminal" }
lvim.builtin.which_key.mappings["vv"] = { ":ToggleTerm<CR>", "Toggle Terminal" }
lvim.builtin.which_key.mappings["v\\"] = { ":VTerm<CR>", "| Term" }
lvim.builtin.which_key.mappings["v-"] = { ":Term<CR>", "- Term" }
lvim.builtin.which_key.mappings["b<Space>"] = { "<cmd>Telescope buffers<cr>", "Switch Buffers" }
-- builtin <leader>be to choose a buffer to delete
lvim.builtin.which_key.mappings["bd"] = { ":bd<cr>", "Close/Delete Current Buffer" }
lvim.builtin.which_key.mappings["bw"] = { "<cmd>%s/\\s\\+$//e<cr>:noh<cr>", "Trail Whitespace Clean" }
lvim.builtin.which_key.mappings["xx"] = { ":QuickRun<CR>", "QuickRun" }
lvim.builtin.which_key.mappings["rl"] = { ":Telescope resume<CR>", "Resume" }
lvim.builtin.which_key.mappings["ss"] = {
	":lua require('telescope.builtin').current_buffer_fuzzy_find({sorter = require('telescope.sorters').get_substr_matcher({})})<CR>",
	"Search Buffer",
}
lvim.builtin.which_key.mappings["<Tab>"] = { ":BufferLineCycleNext<CR>", "Next Tab" }
lvim.builtin.which_key.mappings["<S-Tab>"] = { ":BufferLineCyclePrev<CR>", "Prev Tab" }
-- original / is to comment
lvim.builtin.which_key.mappings["/"] = { ":Telescope current_buffer_fuzzy_find fuzzy=false<CR>", "Search Buffer" }
lvim.builtin.which_key.mappings["sP"] = { "<cmd>Telescope live_grep<CR>", "Live Search" }
lvim.builtin.which_key.mappings["l/"] = { ":Telescope lsp_document_symbols<CR>", "Document Symbols" }
lvim.builtin.which_key.mappings["l."] = { ":Telescope lsp_workspace_symbols<CR>", "Workspace Symbols" }
lvim.builtin.which_key.mappings["LL"] = { ":Lazy<CR>", "Lazy Plugins Manager" }
lvim.builtin.which_key.mappings["dI"] = { ':lua require("dapui").eval()<CR>', "Dap Hover Info" }
lvim.builtin.which_key.mappings["dl"] = { ':lua require("dap").run_last()<CR>', "Dap Run Last Debug" }
lvim.builtin.which_key.mappings["dv"] = {
	":lua local widgets = require('dap.ui.widgets'); local sidebar = widgets.sidebar(widgets.scopes); sidebar.open();<CR>",
	"Dap Varaibles Sidebar",
}
lvim.builtin.which_key.mappings["dS"] = {
	":RustDebuggables<CR>",
	"Rust Start Debug",
}
lvim.builtin.which_key.mappings["d<Space>"] = { ':lua require("dapui").toggle()<CR>', "Dapui Toggle" }
lvim.builtin.which_key.mappings["dQ"] = {
	-- bind multiple commands into one key
	':lua require("dap").close()<CR>:lua require("dapui").close()<CR> ',
	"Quit Dap and Dapui",
}

lvim.builtin.which_key.mappings["t"] = {
	name = "+Toggle",
	-- from rrethy/vim-hexokinase
	-- c = { ":HexokinaseToggle<CR>", "Toggle Color" },
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
	b = { "<cmd>Telescope keymaps fuzzy=false<CR>", "Keybindings" },
	H = { "<cmd>Telescope highlights<CR>", "Higlights" },
}
lvim.builtin.which_key.mappings["f"] = {
	name = "+Files",
	F = { "<cmd>Telescope find_files<CR>", "Find Project Files" },
	-- find files from PWD/CWD(current working directory)
	f = {
		"<cmd>:lua require 'telescope.builtin'.find_files{ cwd = '%:p:h' }<CR>",
		"Find Files",
	},
	a = {
		"<cmd>:lua require 'telescope.builtin'.find_files{find_command={'fd', '--type', 'f', '-HI', '--strip-cwd-prefix'}}<CR>",
		"Find Project All Files",
	},
	r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
	n = { "<cmd>enew<CR>", "New File" },
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
	["<Left>"] = { "<C-w><Left>", "Switch to Left window" },
	["<Right>"] = { "<C-w><Right>", "Switch to Right window" },
	["<Up>"] = { "<C-w><Up>", "Switch to Up window" },
	["<Down>"] = { "<C-w><Down>", "Switch to Down window" },
	["<space>"] = { ":call ToggleWindowSplit()<CR>", "Toggle Layout" },
}
lvim.builtin.which_key.mappings["lt"] = {
	name = "+Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	d = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	D = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	L = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}
lvim.builtin.which_key.mappings["C"] = nil
lvim.builtin.which_key.mappings["c"] = {
	name = "+Cargo",
	["<space>"] = { ":CargoBuild<cr>", "Cargo build" },
	a = { ":lua require('crates').update_crate()<cr>", "Crates Update" },
	A = { ":lua require('crates').update_all_crates()<cr>", "Crates Update All" },
	b = { ":CargoBuild<cr>", "Cargo build" },
	B = { ":CargoBench<cr>", "Cargo benchmarks" },
	c = { ":CargoCheck<cr>", "Cargo check" },
	C = { ":CargoClean<cr>", "Cargo clean" },
	d = { ":CargoDoc<cr>", "Cargo doc" },
	i = { ":lua require('crates').open_crates_io()<cr>", "Crates.io Page" },
	I = { ":lua require('crates').open_documentation()<cr>", "Crate Document" },
	n = { ":CargoNew<cr>", "Cargo new" },
	x = { ":CargoRun<cr>", "Cargo run" },
	R = { ":CargoReload<cr>", "Cargp reload" },
	t = { ":CargoTest<cr>", "Cargo test" },
	u = { ":CargoUpdate<cr>", "Cargo update" },
}
lvim.builtin.which_key.mappings["S"] = {
	name = "+SearchReplace",
	s = { ":lua require('spectre').open()<cr>", "SearchReplace Project" },
	S = { ":lua require('spectre').open({select_word=true})<cr>", "SearchReplace Project CW" },
	b = { ":lua require('spectre').open_file_search()<cr>", "SearchReplace CurrentBuffer" },
	B = { ":lua require('spectre').open_file_search({select_word=true})<cr>", "SearchReplace CurrentBuffer CW" },
}

-- -- Change theme settings
lvim.colorscheme = "default"

lvim.transparent_window = true
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.options.theme = "onedark"
lvim.builtin.lualine.sections.lualine_c = { "filename", "diagnostics" }
lvim.builtin.telescope.defaults = {
	-- list the line number from Results window top->down
	sorting_strategy = "ascending",
	layout_config = {
		prompt_position = "top",
	},
}

-- vim configs
vim.cmd([[
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:$,space:·,conceal:·
" treat leading/trail whitespace as error
match errorMsg /\s\+$/
set nowrapscan
" wrap long lines, hard break long line using `gq`
set wrap
" this updatetime affects the CursorHold
set updatetime=1000
" the offset to top/bottom for commands like z<Enter>/zt/z-/zb
set scrolloff=0
" be able to open file with more encodings
set fileencodings=utf8,gb2312,gb18030,ucs-bom,latin1
" if v:version < 800
"     set cmdheight=1
" else
"     set cmdheight=0
" endif

function! ToggleWindowSplit()
	if !exists('t:splitType')
		let t:splitType = 'vertical'
	endif
	if t:splitType == 'vertical' " is vertical switch to horizontal
		windo wincmd K
		let t:splitType = 'horizontal'
	else " is horizontal switch to vertical
		windo wincmd H
		let t:splitType = 'vertical'
	endif
endfunction
]])

-- TODO
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
-- disable nvimtree since a bug: LunarVim/issues/2512
lvim.builtin.nvimtree.active = false
-- lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- https://github.com/folke/trouble.nvim for more binding in the list
-- C-x/v to open the result in split window, o to open and close the list
-- lvim.lsp.buffer_mappings.normal_mode["gd"] = { ":vsplit<CR><cmd>Trouble lsp_definitions<cr>", "Goto Definitions" }
-- lvim.lsp.buffer_mappings.normal_mode["gr"] = { "<cmd>Trouble lsp_references<cr>", "Goto References" }
-- lvim.lsp.buffer_mappings.normal_mode["gR"] = { "<cmd>Trouble<cr>", "Goto Trouble Lsp List" }
-- lvim.lsp.buffer_mappings.normal_mode["gq"] = { "<cmd>Trouble quickfix<cr>", "QuickFix" }
-- lvim.lsp.buffer_mappings.normal_mode["gl"] = { "<cmd>Trouble loclist<cr>", "LocationList" }
-- lvim.lsp.buffer_mappings.normal_mode["gt"] = { "<cmd>Trouble lsp_type_definitions<cr>", "Show Type Definition" }
-- lvim.lsp.buffer_mappings.normal_mode["gD"] = { "<cmd>Trouble document_diagnostics<cr>", "List Document Diagnostics" }
-- lvim.lsp.buffer_mappings.normal_mode["gw"] = { "<cmd>Trouble workspace_diagnostics<cr>", "List Workspace Diagnostics" }

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

-- User Config for predefined plugins
lvim.builtin.terminal.float_opts = {
	-- bottom-right floating terminal with 50% of the width/height of current vim window
	width = function(_term)
		local width = math.ceil(vim.o.columns / 2)
		_term.float_opts.col = vim.o.columns - width
		-- _term.float_opts.col = 0
		return width
	end,
	height = function(_term)
		local height = math.ceil(vim.o.lines / 2)
		_term.float_opts.row = vim.o.lines - height - 4
		-- _term.float_opts.row = 0
		return height
	end,
}

-- If you don't want all the parsers change this to a table of the ones you want
-- You may need to :TSupdate if vim has tree-sitter issues
require("nvim-treesitter.configs").setup({
	ensure_installed = {
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
	},
	ignore_install = { "haskell" },
	highlight = { enabled = true },
})

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters, formatters and code actions <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	-- { command = "stylua" },
	{ command = "fish_indent", filetypes = { "fish" } },
	{ command = "shfmt",       filetypes = { "sh" } },
	{ command = "black",       filetypes = { "python" } },
	{ command = "isort",       filetypes = { "python" } },
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

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "flake8", filetypes = { "python" } },
	{
		-- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
		command = "shellcheck",
		---@usage arguments to pass to the formatter
		-- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
		extra_args = { "--severity", "warning" },
	},
	{
		command = "codespell",
		---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
		filetypes = { "javascript", "python" },
	},
})
-- local code_actions = require "lvim.lsp.null-ls.code_actions"
-- code_actions.setup {
--   {
--     exe = "eslint",
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- Additional Plugins,
lvim.plugins = {
	--     {"folke/tokyonight.nvim"},
	{ "folke/trouble.nvim", cmd = "TroubleToggle" },
	{ "szw/vim-maximizer" },
	{
		"brenoprata10/nvim-highlight-colors",
		config = true
		-- config = function()
		-- 	require("nvim-highlight-colors").setup()
		-- end,
	},
	{ "vimlab/split-term.vim" },
	{ "thinca/vim-quickrun" },
	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				-- lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
				lastplace_open_folds = true,
			})
		end,
	},
	{
		"folke/flash.nvim",
		config = true
		-- config = function()
		-- 	require("flash").setup()
		-- end,
	},
	{
		url = "https://gitlab.com/yorickpeterse/nvim-window.git",
		config = function()
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
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = true
		-- config = function()
		-- 	require("nvim-dap-virtual-text").setup()
		-- end,
	},
	{ "timonv/vim-cargo" },
	-- ds"(delete "), cs"'(chanage " to '), ysw"(add the next word double ")
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({
				keymaps = {
					-- vim-surround style keymaps
					-- insert = "ys",
					-- visual = "S",
					delete = "ds",
					change = "cs",
				},
			})
		end,
	},
	{
		"vigoux/notifier.nvim",
		config = true
		-- config = function()
		--   require'notifier'.setup {
		--   -- You configuration here
		--   }
		-- end
	},
	-- {
	-- 	"j-hui/fidget.nvim",
	-- 	version = "legacy",
	-- 	config = true
	-- 	-- config = function()
	-- 	-- 	require("fidget").setup()
	-- 	-- end,
	-- },
	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			require("lspsaga").setup({
				finder = {
					max_height = 0.6,
					force_max_height = true,
				},
			})
		end,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	-- FIXME: "[LSP] No client with id 1" msg when opening rust file with lvim
	-- https://github.com/LunarVim/LunarVim/discussions/3201
	{
		"simrat39/rust-tools.nvim",
		config = function()
			local status_ok, rust_tools = pcall(require, "rust-tools")
			if not status_ok then
				return
			end

			local opts = {
				tools = {
					executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
					reload_workspace_from_cargo_toml = true,
					inlay_hints = {
						auto = true,
						only_current_line = false,
						show_parameter_hints = true,
						parameter_hints_prefix = "<-",
						other_hints_prefix = "=>",
						max_len_align = false,
						max_len_align_padding = 1,
						right_align = false,
						right_align_padding = 7,
						highlight = "Ignore",
					},
					hover_actions = {
						--border = {
						--        { "╭", "FloatBorder" },
						--        { "─", "FloatBorder" },
						--        { "╮", "FloatBorder" },
						--        { "│", "FloatBorder" },
						--        { "╯", "FloatBorder" },
						--        { "─", "FloatBorder" },
						--        { "╰", "FloatBorder" },
						--        { "│", "FloatBorder" },
						--},
						auto_focus = true,
					},
				},
				server = {
					on_attach = require("lvim.lsp").common_on_attach,
					on_init = require("lvim.lsp").common_on_init,
					settings = {
						["rust-analyzer"] = {
							check = {
								command = "clippy",
								extraArgs = { "--all", "--", "-W", "clippy::all" },
							},
						},
					},
				},
			}
			--local extension_path = vim.fn.expand "~/" .. ".vscode/extensions/vadimcn.vscode-lldb-1.7.3/"

			--local codelldb_path = extension_path .. "adapter/codelldb"
			--local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

			--opts.dap = {
			--        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
			--}
			rust_tools.setup(opts)
		end,
		ft = { "rust", "rs" },
	},
	{
		"saecki/crates.nvim",
		ft = { "rust", "toml" },
		config = true
		-- config = function()
		-- 	require("crates").setup()
		-- end,
	},
	{
		"windwp/nvim-spectre",
		event = "BufRead",
		config = true
		-- config = function()
		-- 	require("spectre").setup()
		-- end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {}
	}
} -- end of personal plugins

require("telescope").setup({
	pickers = {
		find_files = {
			hidden = true,
			theme = "ivy",
			path_display = { nil },
		},
	},
})

require("cmp").setup({
	sources = {
		-- for crates.nvim in Crate.toml file
		{ name = "crates" },
	},
})

require("indent_blankline").setup({
	space_char_blankline = " ",
	show_first_indent_leve = true,
	-- NOTE: enabling the following line will cause error msg for empty lvim session
	-- show_current_context = true,
	show_current_context_start = true,
	char_highlight_list = {
		"IndentBlanklineIndent1",
	},
})

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
-- TODO
lvim.autocommands = {
	-- On entering a lua file, set the tab spacing and shift width to 8
	{ "BufWinEnter", { pattern = { "*.lua" }, command = "set noexpandtab ts=2 sw=2" } },
	{ "BufEnter",    { pattern = { "*.c", "*.h" }, command = "set noexpandtab tabstop=8 shiftwidth=8" } },
	{ "BufEnter",    { pattern = { "*.cpp", "*.cc", "*.hpp" }, command = "set noexpandtab tabstop=4 shiftwidth=4" } },
	{ "BufRead",     { pattern = { "*.fish" }, command = "set expandtab tabstop=4 shiftwidth=4" } },
	-- auto hover when cursot is stopped at something
	-- {
	-- 	"CursorHold,CursorHoldI,MenuPopup",
	-- 	{ pattern = { "*" }, command = "lua require 'gitsigns'.preview_hunk()" },
	-- },
	-- hover can maually triggered by K
	-- * if &filetype != "latex" && &filetype != "plaintex" | do
	--{
	--	"CursorHold,CursorHoldI,MenuPopup",
	--	{ pattern = { "*" }, command = 'if &ft != "fish" | lua vim.lsp.buf.hover()' },
	--},
	-- start insert when editing git commit message
	{ "FileType",    { pattern = { "gitcommit" }, command = "startinsert" } },
	-- for color and borders of pop windows likes which-key and lsp
	{ "ColorScheme", { pattern = { "*" }, command = "highlight Pmenu ctermbg=NONE guibg=NONE" } },
	{ "ColorScheme", { pattern = { "*" }, command = "highlight FloatBorder ctermbg=NONE guibg=NONE" } },
	{ "ColorScheme", { pattern = { "*" }, command = "highlight IndentBlanklineIndent1 guifg=gray gui=nocombine" } },
}

-- set commentstring for some filetypes
-- https://github.com/numToStr/Comment.nvim#%EF%B8%8F-filetypes--languages
-- dosinit is for files like /etc/pacman.conf and /etc/pacman.d/*list
-- "" for files wich filetype is empty
require("Comment.ft")({ "", "gitconfig", "dosini", "org" }, "#%s")
require("Comment.ft")({ "kdl" }, "// %s")

-- debugger -- dap
lvim.builtin.dap.active = true
require("nvim-dap-virtual-text").setup({
	enabled = true,
	enabled_commands = true,
	highlight_changed_variables = true,
	highlight_new_as_changed = true,
	show_stop_reason = true,
	commented = false,
	-- experimental features:
	virt_text_pos = "eol",
	all_frames = false,
	virt_lines = false,
	virt_text_win_col = nil,
	-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
})
-- dapui
--require("dapui").setup()
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
--
lvim.builtin.dap.on_config_done = function(dap)
	dap.adapters.lldb = {
		type = "executable",
		command = "/usr/bin/lldb-vscode",
		name = "lldb",
	}

	dap.configurations.cpp = {
		{
			name = "Launch",
			type = "lldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = {},
			runInTerminal = false,
			autoReload = {
				enable = true,
			},
		},
		{
			-- If you get an "Operation not permitted" error using this, try disabling YAMA:
			--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
			name = "Attach to process",
			type = "lldb",
			request = "attach",
			pid = require("dap.utils").pick_process,
			args = {},
		},
	}
	dap.configurations.c = dap.configurations.cpp
	dap.configurations.rust = dap.configurations.cpp
end
