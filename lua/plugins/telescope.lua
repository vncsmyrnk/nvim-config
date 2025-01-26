local custom_find_files = function(title, paths_list, opts)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local find_command = { "fd", ".", "--unrestricted", "--type", "f" }
  vim.list_extend(find_command, paths_list)

  pickers
    .new(opts, {
      prompt_title = title,
      __locations_input = true,
      finder = finders.new_oneshot_job(find_command, opts),
      previewer = conf.grep_previewer(opts),
      sorter = conf.file_sorter(opts),
    })
    :find()
end

local custom_change_dir = function(title, paths_list, opts)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local conf = require("telescope.config").values
  local find_command = { "fd", ".", "--max-depth", 1, "-t", "d" }
  vim.list_extend(find_command, paths_list)

  pickers
    .new(opts, {
      prompt_title = title,
      __locations_input = true,
      finder = finders.new_oneshot_job(find_command, opts),
      sorter = conf.file_sorter(opts),
      previewer = conf.grep_previewer(opts),
      attach_mappings = function()
        actions.select_default:replace(function(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          vim.cmd(string.format("tcd %s", selection.value))
        end)
        return true
      end,
    })
    :find()
end

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
        pickers = {
          buffers = {
            mappings = {
              i = {
                ["<M-d>"] = actions.delete_buffer + actions.move_to_top,
              },
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
            find_command = { "fd", "--unrestricted", "--type", "f", "-E", ".git" },
          })
        end,
        desc = "Telescope: Fuzzy finder",
      },
      {
        "<leader>fc",
        function()
          local paths = os.getenv("UTILS_CUSTOM_DOCS_DIR") or string.format("%s/%s", os.getenv("HOME"), "Documents")
          local paths_list = vim.split(paths, " ")
          custom_find_files("Find documents", paths_list, {})
        end,
        desc = "Telescope: Find custom documents",
      },
      {
        "<leader>fp",
        function()
          local paths = os.getenv("UTILS_PROJECTS_DIR") or string.format("%s/%s", os.getenv("HOME"), "workspace")
          local paths_list = vim.split(paths, " ")
          custom_change_dir("Change project directory", paths_list, {})
        end,
        desc = "Telescope: Change project",
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
