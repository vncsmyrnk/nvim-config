return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    branch = "0.1.x",
    dependencies = {
      { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local lga_actions = require("telescope-live-grep-args.actions")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-Down>"] = require("telescope.actions").cycle_history_next,
              ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-space>"] = actions.to_fuzzy_refine,
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
        function()
          require("telescope.builtin").find_files({
            find_command = { "fd", "--hidden", "--type", "f", "-E", ".git", "--no-ignore" },
          })
        end,
        desc = "Telescope: Fuzzy finder",
      },
      {
        "<leader>fp",
        function()
          local pickers = require("telescope.pickers")
          local finders = require("telescope.finders")
          local actions = require("telescope.actions")
          local action_state = require("telescope.actions.state")
          local conf = require("telescope.config").values
          local home_path = os.getenv("HOME")

          local opts = {}

          pickers
            .new(opts, {
              prompt_title = "Change working directory",
              __locations_input = true,
              finder = finders.new_oneshot_job(
                { "fd", "--base-directory", home_path, "--max-depth", 5, "-t", "d" },
                opts
              ),
              sorter = conf.file_sorter(opts),
              attach_mappings = function()
                actions.select_default:replace(function(prompt_bufnr)
                  local selection = action_state.get_selected_entry()
                  actions.close(prompt_bufnr)
                  vim.cmd("cd " .. home_path .. package.config:sub(1, 1) .. selection.value)
                end)
                return true
              end,
            })
            :find()
        end,
        desc = "Telescope: Project Fuzzy finder",
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
        "<leader>fk",
        "<cmd>Telescope keymaps<cr>",
        desc = "Telescope: Search keymaps",
      },
      {
        "<leader>fh",
        "<cmd>Telescope help_tags<cr>",
        desc = "Telescope: Search help tags",
      },
      {
        "<leader>fo",
        "<cmd>Telescope vim_options<cr>",
        desc = "Telescope: Search vim options",
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
}
