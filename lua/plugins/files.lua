return {
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    opts = {
      columns = {
        "icon",
        "permissions",
        "size",
      },
      float = {
        border = "rounded",
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
    "ibhagwan/fzf-lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      local fzf = require("fzf-lua")
      fzf.register_ui_select()
    end,
    opts = {
      "border-fused",
      "hide",
      keymap = {
        builtin = {
          true,
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        },
        fzf = {
          true,
          ["ctrl-q"] = "select-all+accept",
        },
      },
    },
    keys = {
      {
        "<C-p>",
        function()
          require("fzf-lua").git_files()
        end,
        desc = "fzf: git files",
      },
      {
        "<leader>F",
        function()
          require("fzf-lua").files({
            cwd = "~",
            hidden = true,
            no_ignore = true,
          })
        end,
        desc = "fzf: user files",
      },
      {
        "<leader>ff",
        function()
          require("fzf-lua").files({ hidden = true, no_ignore = true })
        end,
        desc = "fzf: project files",
      },
      {
        "<leader>fp",
        function()
          local paths = os.getenv("UTILS_PROJECTS_DIR") or string.format("%s/%s", os.getenv("HOME"), "workspace")
          local cmd = string.format("fd . %s --max-depth 1 --type d", paths)
          local select_action = function(selected)
            local fzf_path = require("fzf-lua.path")
            local file = fzf_path.entry_to_file(selected[1], {}, false)
            vim.cmd(string.format("tcd %s", file.path))
          end

          require("fzf-lua").files({
            cmd = cmd,
            cwd_prompt = false,
            cwd_header = false,
            actions = { ["enter"] = select_action },
          })
        end,
        desc = "fzf: change working directory",
      },
      {
        "<leader>fc",
        function()
          local paths = os.getenv("UTILS_CUSTOM_DOCS_DIR") or string.format("%s/%s", os.getenv("HOME"), "Documents")
          local cmd = string.format("fd . %s --unrestricted --type f", paths)

          require("fzf-lua").files({
            cmd = cmd,
            cwd_prompt = false,
            cwd_header = false,
          })
        end,
        desc = "fzf: change working directory",
      },
      {
        "<leader>fa",
        function()
          local sep = package.config:sub(1, 1)
          require("fzf-lua").live_grep({
            cwd_only = vim.fn.getcwd() .. sep,
            no_ignore = true,
            hidden = true,
            follow = true,
          })
        end,
        desc = "fzf: live grep in cwd",
      },
      {
        "<leader>fA",
        function()
          require("fzf-lua").live_grep_glob()
        end,
        desc = "fzf: live grep",
      },
      {
        "<leader>fb",
        function()
          require("fzf-lua").buffers()
        end,
        desc = "fzf: open buffers",
      },
      {
        "<leader>fd",
        function()
          require("fzf-lua").diagnostics_document()
        end,
        desc = "fzf: diagnostics",
      },
      {
        "<leader>fl",
        function()
          require("fzf-lua").resume()
        end,
        desc = "fzf: resume last",
      },
      {
        "<leader>fhc",
        function()
          require("fzf-lua").command_history()
        end,
        desc = "fzf: command history",
      },
      {
        "<leader>fhs",
        function()
          require("fzf-lua").search_history()
        end,
        desc = "fzf: search history",
      },
      {
        "<leader>fm",
        function()
          require("fzf-lua").man_pages()
        end,
        desc = "fzf: man pages",
      },
      {
        "<leader>ft",
        function()
          require("fzf-lua").help_tags()
        end,
        desc = "fzf: help tags",
      },
      {
        "<leader>fk",
        function()
          require("fzf-lua").keymaps()
        end,
        desc = "fzf: keymaps",
      },
      {
        "<leader>fgd",
        function()
          require("fzf-lua").git_diff()
        end,
        desc = "fzf: git diff",
      },
      {
        "<leader>fgh",
        function()
          require("fzf-lua").git_hunks()
        end,
        desc = "fzf: git hunks",
      },
    },
  },
}
