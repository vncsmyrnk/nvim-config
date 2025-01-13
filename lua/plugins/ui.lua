return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    branch = "0.1.x",
    dependencies = {
      { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-Down>"] = require("telescope.actions").cycle_history_next,
              ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
            },
          },
        },
      })
      telescope.load_extension("live_grep_args")
      require("telescope").load_extension("rest")
    end,
    keys = {
      {
        "<leader>ff",
        "<cmd>Telescope find_files<cr>",
        desc = "Telescope: Fuzzy finder",
      },
      {
        "<leader>fF",
        function()
          require("telescope.builtin").find_files({
            find_command = { "fd", "--hidden", "--type", "f", "-E", ".git" },
          })
        end,
        desc = "Telescope: Fuzzy finder (hidden files)",
      },
      {
        "<leader>fa",
        function()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "Telescope: Live grep with args (rg)",
      },
      {
        "<leader>fb",
        function()
          require("telescope.builtin").buffers({
            sort_mru = true,
            ignore_current_buffer = true,
          })
        end,
        desc = "Telescope: Buffers",
      },
      {
        "<leader>fc",
        function()
          local input = vim.fn.input("Custom location: ")
          require("telescope.builtin").find_files({ cwd = input })
        end,
        desc = "Telescope: Custom path find files",
      },
      {
        "<leader>fd",
        function()
          require("telescope.builtin").diagnostics({ bufnr = 0 })
        end,
        desc = "Telescope: LSP diagnostics",
      },
      {
        "<leader>fm",
        "<cmd>Telescope man_pages<cr>",
        desc = "Telescope: man pages",
      },
      {
        "<leader>fr",
        "<cmd>Telescope lsp_references<cr>",
        desc = "Telescope: LSP references",
      },
      {
        "<leader>fs",
        "<cmd>Telescope search_history<cr>",
        desc = "Telescope: Search history",
      },
      {
        "<leader>fl",
        "<cmd>Telescope resume<cr>",
        desc = "Telescope: Open last search",
      },
      {
        "<leader>fgc",
        "<cmd>Telescope git_commits<cr>",
        desc = "Telescope: Git commits",
      },
      {
        "<leader>fgs",
        "<cmd>Telescope git_status<cr>",
        desc = "Telescope: Git status",
      },
      {
        "<leader>fgb",
        "<cmd>Telescope git_branches<cr>",
        desc = "Telescope: Git branches",
      },
      {
        "<leader>fer",
        function()
          require("telescope").extensions.rest.select_env()
        end,
        desc = "Telescope: Rest environment select",
      },
      {
        "<C-p>",
        "<cmd>Telescope git_files<cr>",
        desc = "Telescope: Git project files",
      },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>a", group = "AI/Copilot" },
        { "<leader>c", group = "Code" },
        { "<leader>cg", group = "Golang" },
        { "<leader>f", group = "File find" },
        { "<leader>fg", group = "File find (Git)" },
        { "<leader>fe", group = "File find (environment)" },
        { "<leader>e", group = "File explorer" },
        { "<leader>g", group = "Git" },
        { "<leader>i", group = "Insert snippets" },
        { "<leader>ip", group = "Insert snippets (PHP)" },
        { "<leader>m", group = "Markdown" },
        { "<leader>n", group = "Noice (notify)" },
        { "<leader>o", group = "Oil" },
        { "<leader>q", group = "Quit" },
        { "<leader>r", group = "Rest" },
        { "<leader>s", group = "SQL" },
        { "<leader>t", group = "Tabs" },
        { "<leader>x", group = "Trouble" },

        { "gK", desc = "LSP: Hover" },
        { "gd", desc = "LSP: Go to definition" },
        { "gD", desc = "LSP: Go to declaration" },
        { "gi", desc = "LSP: Go to implementation" },
        { "gO", desc = "LSP: List diagnostics" },
        { "go", desc = "LSP: Go to type definition" },
        { "gr", desc = "LSP: Go to references" },
        { "gs", desc = "LSP: Signature help" },
        { "<F2>", desc = "LSP: Buffer rename" },
        { "<F3>", desc = "LSP: Buffer format" },
        { "<F4>", desc = "LSP: Code actions" },

        { "<F5>", desc = "DAP: Continue" },
        { "<F10>", desc = "DAP: Step over" },
        { "<F11>", desc = "DAP: Step into" },
        { "<F12>", desc = "DAP: Step out" },
        { "<leader>b", desc = "DAP: Toggle breakpoint" },
        { "<leader>dr", desc = "DAP: Open REPL" },
        { "<leader>dl", desc = "DAP: Run last" },
        { "<leader>du", desc = "DAP: Toggle UI" },
        { "<leader>de", desc = "DAP: Eval under the cursor" },
        { "<leader>dd", desc = "DAP: Disconnect" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local colors = {
        blue = "#80ccff",
        cyan = "#79dac8",
        black = "#080808",
        white = "#c6c6c6",
        red = "#ff5189",
        violet = "#8385e8",
        grey = "#303030",
      }

      local theme = {
        normal = {
          a = { fg = colors.black, bg = colors.violet },
          b = { fg = colors.white, bg = colors.grey },
          c = { fg = colors.white },
        },

        insert = { a = { fg = colors.black, bg = colors.blue } },
        visual = { a = { fg = colors.black, bg = colors.cyan } },
        replace = { a = { fg = colors.black, bg = colors.red } },

        inactive = {
          a = { fg = colors.white, bg = colors.black },
          b = { fg = colors.white, bg = colors.black },
          c = { fg = colors.white },
        },
      }

      local function search_result()
        if vim.v.hlsearch == 0 then
          return ""
        end
        local last_search = vim.fn.getreg("/")
        if not last_search or last_search == "" then
          return ""
        end
        local searchcount = vim.fn.searchcount({ maxcount = 9999 })
        return last_search .. " (" .. searchcount.current .. "/" .. searchcount.total .. ")"
      end

      require("lualine").setup({
        options = {
          theme = theme,
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 1)
              end,
            },
          },
          lualine_c = {
            {
              "filename",
              path = 1,
            },
          },
          lualine_x = {
            "rest",
            "copilot",
          },
          lualine_y = {
            search_result,
            "progress",
            "filesize",
            "filetype",
          },
        },
      })
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      { "<leader>ee", "<cmd>Neotree toggle<cr>", desc = "Neotree toggle" },
      { "<leader>ef", "<cmd>Neotree reveal<cr>", desc = "Neotree reveal" },
      { "<leader>eg", "<cmd>Neotree git_status<cr>", desc = "Neotree git status" },
    },
  },

  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    opts = {},
    keys = {
      { "<leader>o", "<cmd>Oil --float<cr>", desc = "Oil opens current dir in a float window" },
    },
    lazy = false,
  },

  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "voldikss/vim-floaterm",
    cmd = "FloatermNew",
    config = function()
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.8
    end,
    keys = {
      { "<leader>gl", "<cmd>FloatermNew lazygit<cr>", desc = "LazyGit" },
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      messages = {
        enabled = false,
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
      routes = {
        {
          view = "split",
          filter = { event = "msg_show", min_height = 20 },
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    keys = {
      {
        "<leader>nl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice Last Message",
      },
      {
        "<leader>nh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice History",
      },
      {
        "<leader>na",
        function()
          require("noice").cmd("all")
        end,
        desc = "Noice All",
      },
      {
        "<leader>nd",
        function()
          require("noice").cmd("dismiss")
        end,
        desc = "Dismiss All",
      },
    },
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("dashboard").setup({
        config = {
          week_header = {
            enable = true,
          },
          shortcut = {
            { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
            {
              desc = " dotfiles",
              group = "Number",
              action = "Telescope find_files follow=true cwd=$HOME/.config/nvim",
              key = "d",
            },
            {
              desc = " Current folder",
              group = "DashboardFiles",
              action = "Telescope find_files follow=true cwd=.",
              key = "f",
            },
            { desc = "⎚ Empty file", group = "DashboardMruTitle", action = "e /tmp/newfile", key = "e" },
          },
          packages = { enable = true },
          project = { enable = true, limit = 8, label = "Recent projects", action = "Telescope find_files cwd=" },
          mru = { limit = 10, label = "Recent files", cwd_only = false },
          footer = {},
        },
      })
    end,
  },

  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    keys = {
      { "<leader>md", "<cmd>Markview disable<cr>", desc = "Markview: disable" },
      { "<leader>mD", "<cmd>Markview disableAll<cr>", desc = "Markview: disable all" },
      { "<leader>me", "<cmd>Markview enable<cr>", desc = "Markview: enable" },
      { "<leader>mE", "<cmd>Markview enableAll<cr>", desc = "Markview: enable all" },
    },
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      -- vim.g.dbs = {}
    end,
  },

  -- INFO: https://www.jetbrains.com/help/idea/exploring-http-syntax.html
  {
    "rest-nvim/rest.nvim",
    cmd = "Rest",
    keys = {
      { "<leader>rr", "<cmd>Rest run<cr>", desc = "Rest: run" },
      { "<leader>rh", "<cmd>hor Rest run<cr>", desc = "Rest: run (open above)" },
    },
  },

  { "sindrets/diffview.nvim" },
}
