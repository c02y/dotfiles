-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        startofline = true,
        -- check the file encoding of a file using `uchardet thefile` (instead of `file -bi thefile`)
        -- convert the file to utf-8 using `iconv -f gb18030 -t utf-8 -o thefile2 thefile`
        fileencodings = { "utf-8", "gb2312", "gb18030", "ucs-bom", "latin1" },
        -- TODO:more for different types
        -- shiftwidth = 4,
        -- tabstop = 4,
        -- for toggling whitespace
        listchars = {
          tab = "» ",
          extends = "›",
          precedes = "‹",
          nbsp = "·",
          trail = "·",
          eol = "$",
          space = "·",
          conceal = "·",
        },
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- navigate buffer tabs with `H` and `L`
        L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<Leader><s-tab>"] = {
          function() require("astrocore.buffer").prev() end,
          desc = "Previous buffer",
        },
        ["<Leader><tab>"] = {
          function() require("astrocore.buffer").nav(vim.v.count1) end,
          desc = "Next Tab",
        },

        ["<Leader>pr"] = { ":AstroRootInfo<CR>", desc = "Project Root Info" },
        ["<Leader>pv"] = { ":AstroVersion<CR>", desc = "AstroNvim Version" },

        ["<Leader>im"] = { "i// vim: set ft=markdown:<Esc>b", desc = "Insert the filetype" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
        ["<C-w>t"] = {
          ":exe '1wincmd w | wincmd '.(winwidth(0) == &columns ? 'H' : 'K')<CR>",
          desc = "Toggle Windows Layout",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,

        -- https://github.com/rmagatti/goto-preview
        ["gp"] = { desc = "Goto Preview" }, -- binding prefix
        ["gpd"] = { function() require("goto-preview").goto_preview_definition() end, desc = "Preview Definition" },
        ["gpt"] = {
          function() require("goto-preview").goto_preview_type_definition() end,
          desc = "Preview Type Definition",
        },
        ["gpi"] = {
          function() require("goto-preview").goto_preview_implementation() end,
          desc = "Preview Implementation",
        },
        ["gpD"] = { function() require("goto-preview").goto_preview_declaration() end, desc = "Preview Declaration" },
        ["gP"] = { function() require("goto-preview").close_all_win() end, desc = "Preview Close All" },
        ["gpr"] = { function() require("goto-preview").goto_preview_references() end, desc = "Preview References" },
      },
      v = {
        -- more: https://github.com/junegunn/vim-easy-align
        ["g="] = { ":EasyAlign ", desc = "Easy Align" },
      },
    },

    -- Configure project root detection, check status with `:AstroRootInfo`
    rooter = {
      -- list of detectors in order of prevalence, elements can be:
      --   "lsp" : lsp detection
      --   string[] : a list of directory patterns to look for
      --   fun(bufnr: integer): string|string[] : a function that takes a buffer number and outputs detected roots
      detector = {
        "lsp", -- highest priority is getting workspace from running language servers
        { ".git", "_darcs", ".hg", ".bzr", ".svn" }, -- next check for a version controlled parent directory
        { "lua", "MakeFile", "package.json" }, -- lastly check for known project root files
      },
      -- ignore things from root detection
      ignore = {
        servers = {}, -- list of language server names to ignore (Ex. { "efm" })
        dirs = {}, -- list of directory patterns (Ex. { "~/.cargo/*" })
      },
      -- automatically update working directory (update manually with `:AstroRoot`)
      -- NOTE: this will cause error sometimes
      autochdir = true,
      -- scope of working directory to change ("global"|"tab"|"win")
      scope = "tab",
      -- show notification on every working directory change
      notify = false,
    },
  },
}
