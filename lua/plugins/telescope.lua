local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")

local custom_file_picker
custom_file_picker = function(title, cmd, find_command, paths_list, opts)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local conf = require("telescope.config").values
  local final_find_command = vim.list_slice(find_command)
  vim.list_extend(final_find_command, paths_list)

  pickers
    .new(opts, {
      prompt_title = title,
      __locations_input = true,
      finder = finders.new_oneshot_job(final_find_command, opts),
      sorter = conf.file_sorter(opts),
      previewer = conf.grep_previewer(opts),
      attach_mappings = function(_, map)
        actions.select_default:replace(function(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          vim.cmd(string.format(cmd, selection.value))
        end)
        map({ "i", "n" }, "<Right>", function(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          custom_file_picker(title, cmd, find_command, { selection.value }, opts)
        end)
        map({ "i", "n" }, "<Left>", function(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          local parent_dir = vim.fs.joinpath(selection.value, "..", "..")
          actions.close(prompt_bufnr)
          custom_file_picker(title, cmd, find_command, { vim.fs.normalize(parent_dir) }, opts)
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
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    config = function()
      local actions = require("telescope.actions")
      local lga_actions = require("telescope-live-grep-args.actions")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
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
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_ivy({}),
          },
        },
      })
      telescope.load_extension("live_grep_args")
      telescope.load_extension("ui-select")
      telescope.load_extension("rest")
    end,
    keys = {
      {
        "<leader>ff",
        function()
          telescope_builtin.find_files({
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
          local find_command = { "fd", ".", "--unrestricted", "--type", "f" }
          custom_file_picker("Find documents", "e %s", find_command, paths_list, {})
        end,
        desc = "Telescope: Find custom documents",
      },
      {
        "<leader>fp",
        function()
          local paths = os.getenv("UTILS_PROJECTS_DIR") or string.format("%s/%s", os.getenv("HOME"), "workspace")
          local paths_list = vim.split(paths, " ")
          local find_command = { "fd", ".", "--max-depth", 1, "-t", "d" }
          custom_file_picker("Change project directory", "tcd %s", find_command, paths_list, {})
        end,
        desc = "Telescope: Change project",
      },
      {
        "<leader>fo",
        function()
          local find_command = { "fd", ".", "--max-depth", 5, "-t", "d" }
          custom_file_picker("Open in Oil", "Oil %s", find_command, { os.getenv("HOME") }, {})
        end,
        desc = "Telescope: Open in Oil",
      },
      {
        "<leader>fO",
        "<cmd>Telescope vim_options<cr>",
        desc = "Telescope: Search vim options",
      },
      {
        "<leader>fa",
        function()
          telescope.extensions.live_grep_args.live_grep_args()
        end,
        desc = "Telescope: Live grep with args (rg)",
      },
      {
        "<leader>fb",
        function()
          telescope_builtin.buffers({
            sort_mru = true,
            ignore_current_buffer = true,
          })
        end,
        desc = "Telescope: Buffers",
      },
      {
        "<leader>fm",
        "<cmd>Telescope man_pages<cr>",
        desc = "Telescope: man pages",
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
        "<leader>fl",
        "<cmd>Telescope resume<cr>",
        desc = "Telescope: Open last search",
      },
      {
        "<leader>fsr",
        "<cmd>Telescope lsp_references<cr>",
        desc = "Telescope: LSP references",
      },
      {
        "<leader>fsi",
        "<cmd>Telescope lsp_incoming_calls<cr>",
        desc = "Telescope: LSP incoming calls",
      },
      {
        "<leader>fso",
        "<cmd>Telescope lsp_outgoing_calls<cr>",
        desc = "Telescope: LSP outgoing calls",
      },
      {
        "<leader>fsd",
        "<cmd>Telescope lsp_document_symbols<cr>",
        desc = "Telescope: LSP document symbols",
      },
      {
        "<leader>fsw",
        "<cmd>Telescope lsp_workspace_symbols<cr>",
        desc = "Telescope: LSP workspace symbols",
      },
      {
        "<leader>fsD",
        "<cmd>Telescope diagnostics<cr>",
        desc = "Telescope: LSP diagnostics (project)",
      },
      {
        "<leader>fsd",
        function()
          telescope_builtin.diagnostics({ bufnr = 0 })
        end,
        desc = "Telescope: LSP diagnostics",
      },
      {
        "<leader>fsi",
        "<cmd>Telescope lsp_implementations<cr>",
        desc = "Telescope: LSP implementations",
      },
      {
        "<leader>fsf",
        "<cmd>Telescope lsp_definitions<cr>",
        desc = "Telescope: LSP definitions",
      },
      {
        "<leader>fst",
        "<cmd>Telescope lsp_type_definitions<cr>",
        desc = "Telescope: LSP type definitions",
      },
      {
        "<leader>fq",
        "<cmd>Telescope quickfixhistory<cr>",
        desc = "Telescope: Quickfix list history",
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
          telescope.extensions.rest.select_env()
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
