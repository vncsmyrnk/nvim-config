local utils = require("config.utils")

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        terminal_colors = false,
        on_colors = function(colors)
          colors.bg = "#0d1117"
          colors.border = "#1f242d"
          colors.bg_statusline = "#0d1117"
          colors.bg_dark = "#0a0d12"
          colors.bg_dark1 = "#0a0d12"
          colors.bg_float = "#0a0d12"
          colors.bg_sidebar = "#0a0d12"
        end,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
      notifier = {},
    },
    init = function()
      local progress = vim.defaulttable()
      vim.api.nvim_create_autocmd("LspProgress", {
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
          if not client or type(value) ~= "table" then
            return
          end
          local p = progress[client.id]

          for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
              p[i] = {
                token = ev.data.params.token,
                msg = ("[%3d%%] %s%s"):format(
                  value.kind == "end" and 100 or value.percentage or 100,
                  value.title or "",
                  value.message and (" **%s**"):format(value.message) or ""
                ),
                done = value.kind == "end",
              }
              break
            end
          end

          local msg = {} ---@type string[]
          progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
          end, p)

          local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
          vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
              notif.icon = #progress[client.id] == 0 and " "
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
        end,
      })
    end,
    keys = {
      {
        "<leader>nh",
        function()
          require("snacks.notifier").show_history()
        end,
        desc = "notifier: Show snacks notification history",
      },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>a", group = "AI/CodeCompanion" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "DAP" },
        { "<leader>F", group = "Files in cwd" },
        { "<leader>f", group = "File find" },
        { "<leader>fg", group = "File find (Git)" },
        { "<leader>fh", group = "File find (history)" },
        { "<leader>e", group = "File explorer" },
        { "<leader>g", group = "Git" },
        { "<leader>i", group = "Insert snippets" },
        { "<leader>ip", group = "Insert snippets (PHP)" },
        { "<leader>k", group = "Quickfix list" },
        { "<leader>m", group = "Markdown" },
        { "<leader>n", group = "Snacks notifier" },
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
        { "gp", desc = "LSP: Use the right split (meta)" },
        { "gP", desc = "LSP: Use a new right split (meta)" },
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
      local custom_iceberg_dark = require("lualine.themes.iceberg_dark")
      custom_iceberg_dark.normal.c.bg = "transparent"
      custom_iceberg_dark.inactive.c.bg = "transparent"

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

      local function line_count()
        return tostring(vim.fn.line("$")) .. "L"
      end

      require("lualine").setup({
        options = {
          theme = custom_iceberg_dark,
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            "mode",
          },
          lualine_c = {
            {
              "filename",
              path = 1,
            },
          },
          lualine_x = {
            {
              function()
                if utils.plugin_loaded("kulala.nvim") then
                  local selected_env = require("kulala").get_selected_env()
                  return string.format("kenv: %s", selected_env)
                end
                return ""
              end,
              cond = function()
                local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                local supported_fts = { "http", "text.kulala_ui" }
                return vim.tbl_contains(supported_fts, filetype)
              end,
            },
            "copilot",
          },
          lualine_y = {
            search_result,
            "progress",
            line_count,
            "filesize",
            "filetype",
          },
        },
      })
    end,
  },

  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    opts = {
      columns = {
        "icon",
        "permissions",
        "size",
      },
      keymaps = {
        ["<C-o>"] = function()
          local oil = require("oil")
          local dir = oil.get_current_dir()
          local entry = oil.get_cursor_entry()
          vim.cmd(string.format("tabp | e %s%s", dir, entry.name))
        end,
      },
    },
    keys = {
      { "<leader>of", "<cmd>Oil --float<cr>", desc = "Oil: opens current dir in a float window" },
      { "<leader>ot", "<cmd>tab Oil<cr>", desc = "Oil: opens current dir in a new tab" },
      { "<leader>ov", "<cmd>vertical Oil<cr>", desc = "Oil: opens current dir in a vertical split" },
    },
    lazy = false,
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
              desc = " Config files",
              group = "Number",
              action = "FzfLua files follow=true cwd=$HOME/.config/nvim",
              key = "d",
            },
            {
              desc = " Current folder",
              group = "DashboardFiles",
              action = "FzfLua files follow=true cwd=.",
              key = "f",
            },
            { desc = "⎚ Empty file", group = "DashboardMruTitle", action = "e /tmp/newfile", key = "e" },
          },
          packages = { enable = true },
          project = { enable = true, limit = 8, label = "Recent projects", action = "FzfLua files cwd=" },
          mru = { limit = 10, label = "Recent files", cwd_only = false },
          footer = {},
        },
      })
    end,
  },
}
