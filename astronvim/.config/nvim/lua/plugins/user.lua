-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            " █████  ███████ ████████ ██████   ██████ ",
            "██   ██ ██         ██    ██   ██ ██    ██",
            "███████ ███████    ██    ██████  ██    ██",
            "██   ██      ██    ██    ██   ██ ██    ██",
            "██   ██ ███████    ██    ██   ██  ██████ ",
            "",
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  -- modifed from https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/plugins/toggleterm.lua
  -- f7 -> f8, and chagne it to float terminal
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    specs = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          local astro = require "astrocore"
          maps.n["<Leader>t"] = vim.tbl_get(opts, "_map_sections", "t")
          if vim.fn.executable "git" == 1 and vim.fn.executable "lazygit" == 1 then
            maps.n["<Leader>g"] = vim.tbl_get(opts, "_map_sections", "g")
            local lazygit = {
              callback = function()
                local worktree = astro.file_worktree()
                local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir)
                  or ""
                astro.toggle_term_cmd { cmd = "lazygit " .. flags, direction = "float" }
              end,
              desc = "ToggleTerm lazygit",
            }
            maps.n["<Leader>gg"] = { lazygit.callback, desc = lazygit.desc }
            maps.n["<Leader>tl"] = { lazygit.callback, desc = lazygit.desc }
          end
          if vim.fn.executable "node" == 1 then
            maps.n["<Leader>tn"] = { function() astro.toggle_term_cmd "node" end, desc = "ToggleTerm node" }
          end
          local gdu = vim.fn.has "mac" == 1 and "gdu-go" or "gdu"
          if vim.fn.has "win32" == 1 and vim.fn.executable(gdu) ~= 1 then gdu = "gdu_windows_amd64.exe" end
          if vim.fn.executable(gdu) == 1 then
            maps.n["<Leader>tu"] =
              { function() astro.toggle_term_cmd { cmd = gdu, direction = "float" } end, desc = "ToggleTerm gdu" }
          end
          if vim.fn.executable "btm" == 1 then
            maps.n["<Leader>tt"] =
              { function() astro.toggle_term_cmd { cmd = "btm", direction = "float" } end, desc = "ToggleTerm btm" }
          end
          local python = vim.fn.executable "python" == 1 and "python" or vim.fn.executable "python3" == 1 and "python3"
          if python then
            maps.n["<Leader>tp"] = { function() astro.toggle_term_cmd(python) end, desc = "ToggleTerm python" }
          end
          maps.n["<Leader>tf"] = { "<Cmd>ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }
          maps.n["<Leader>th"] =
            { "<Cmd>ToggleTerm size=10 direction=horizontal<CR>", desc = "ToggleTerm horizontal split" }
          maps.n["<Leader>tv"] =
            { "<Cmd>ToggleTerm size=80 direction=vertical<CR>", desc = "ToggleTerm vertical split" }
          maps.n["<f8>"] = { "<Cmd>ToggleTerm direction=float<CR>", desc = "Toggle terminal" }
          maps.t["<f8>"] = { "<Cmd>ToggleTerm direction=float<CR>", desc = "Toggle terminal" }
          maps.i["<f8>"] = { "<Esc><Cmd>ToggleTerm direction=float<CR>", desc = "Toggle terminal" }
          -- maps.n["<C-'>"] = { '<Cmd>execute v:count . "ToggleTerm"<CR>', desc = "Toggle terminal" } -- requires terminal that supports binding <C-'>
          -- maps.t["<C-'>"] = { "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" } -- requires terminal that supports binding <C-'>
          -- maps.i["<C-'>"] = { "<Esc><Cmd>ToggleTerm<CR>", desc = "Toggle terminal" } -- requires terminal that supports binding <C-'>
        end,
      },
    },
    opts = {
      highlights = {
        Normal = { link = "Normal" },
        NormalNC = { link = "NormalNC" },
        NormalFloat = { link = "NormalFloat" },
        FloatBorder = { link = "FloatBorder" },
        StatusLine = { link = "StatusLine" },
        StatusLineNC = { link = "StatusLineNC" },
        WinBar = { link = "WinBar" },
        WinBarNC = { link = "WinBarNC" },
      },
      size = 10,
      ---@param t Terminal
      on_create = function(t)
        vim.opt_local.foldcolumn = "0"
        vim.opt_local.signcolumn = "no"
        if t.hidden then
          local function toggle() t:toggle() end
          -- vim.keymap.set({ "n", "t", "i" }, "<C-'>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
          vim.keymap.set({ "n", "t", "i" }, "<f8>", toggle, { desc = "Toggle terminal", buffer = t.bufnr })
        end
      end,
      shading_factor = 2,
      float_opts = { border = "rounded" },
    },
  },

  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
      -- check the installation instructions at
      -- https://github.com/folke/snacks.nvim
      "folke/snacks.nvim",
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>fA",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>f<space>",
        "<cmd>Yazi cwd<cr>",
        desc = "Yazi at CWD",
      },
      {
        "<f6>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig | {}
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      -- vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  },

  {
    "fei6409/log-highlight.nvim",
    config = function() require("log-highlight").setup {} end,
  },

  {
    "anuvyklack/windows.nvim",
    dependencies = "anuvyklack/middleclass",
    keys = {
      { "<leader>bm", "<cmd>WindowsMaximize<cr>", desc = "WindowMaximize Buffer" },
    },
    config = function() require("windows").setup {} end,
  },
  {
    "rmagatti/goto-preview",
    event = "BufEnter",
    config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      -- TODO: keep only one of gdb/lldb-dap/codelldb
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }
      dap.adapters.lldb = {
        type = "executable",
        command = "lldb-dap",
        name = "lldb",
      }
      -- dap.adapters.codelldb = {
      --   type = "server",
      --   port = "{port}",
      --   executable = { command = "codelldb", args = { "--port", "${port}" } },
      -- }
      dap.configurations.cpp = {
        {
          name = "My C/CPP/Rust gdb debugger (no args)",
          type = "gdb",
          request = "launch",
          program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
          cwd = "${workspaceFolder}",
          stopOnEntry = true,
          stopAtBeginningOfMainSubprogram = true,
        },
        {
          name = "My C/CPP/Rust gdb debugger (attach)",
          type = "gdb",
          request = "attach",
          program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
          pid = function()
            local name = vim.fn.input "Executable name (filter): "
            return require("dap.utils").pick_process { filter = name }
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = true,
          stopAtBeginningOfMainSubprogram = true,
        },
        {
          name = "My C/CPP/Rust gdb debugger (args)",
          type = "gdb",
          request = "launch",
          program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
          cwd = "${workspaceFolder}",
          -- terminal = "terminal",
          stopOnEntry = true,
          stopAtBeginningOfMainSubprogram = true,
          -- TODO: how to input args
          args = {},
        },
        {
          name = "My C/CPP/Rust lldb-dap debugger (no args)",
          type = "lldb",
          request = "launch",
          program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
          cwd = "${workspaceFolder}",
          stopOnEntry = true,
        },
        -- {
        --   name = "My C/CPP/Rust codelldb debugger (no args)",
        --   type = "codelldb",
        --   request = "launch",
        --   program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
        --   cwd = "${workspaceFolder}",
        --   stopOnEntry = true,
        --   stopAtBeginningOfMainSubprogram = true,
        --   terminal = "terminal",
        -- },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end,
  },
}
