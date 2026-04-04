local must_install = {}
if vim.fn.executable("go") == 1 then
  table.insert(must_install, "delve")
end

return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "mfussenegger/nvim-dap" },
      { "jay-babu/mason-nvim-dap.nvim" },
    },
    config = function()
      require("mason").setup({})
      require("mason-nvim-dap").setup({
        ensure_installed = must_install,
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      })

      local dap = require("dap")
      require("dapui").setup()
      dap.set_log_level("TRACE")

      dap.adapters.delve = {
        type = "server",
        port = "2345",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:2345" },
        },
      }

      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
        {
          type = "delve",
          name = "Attach",
          request = "attach",
          mode = "remote",
          remotePath = "",
          port = "2345",
          host = "127.0.0.1",
        },
      }

      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-dap",
        name = "lldb",
      }

      dap.configurations.rust = {
        {
          type = "lldb",
          name = "Launch",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
        {
          type = "lldb",
          name = "Attach",
          request = "attach",
          port = "2345",
          host = "127.0.0.1",
        },
      }

      dap.configurations.zig = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/zig-out/bin/", "file")
          end,
          args = function()
            local input = vim.fn.input("Args: ")
            return vim.split(input, " ", { trimempty = true })
          end,
          cwd = "${workspaceFolder}",
        },
      }
    end,
    keys = {
      {
        "<F5>",
        '<cmd>lua require"dap".continue()<CR>',
        { noremap = true, silent = true },
      },
      {
        "<F10>",
        '<cmd>lua require"dap".step_over()<CR>',
        { noremap = true, silent = true },
      },
      {
        "<F11>",
        '<cmd>lua require"dap".step_into()<CR>',
        { noremap = true, silent = true },
      },
      {
        "<F12>",
        '<cmd>lua require"dap".step_out()<CR>',
        { noremap = true, silent = true },
      },
      {
        "<leader>b",
        '<cmd>lua require"dap".toggle_breakpoint()<CR>',
        { noremap = true, silent = true },
      },
      {
        "<leader>B",
        '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
        { noremap = true, silent = true },
      },
      {
        "<leader>dr",
        '<cmd>lua require"dap".repl.open()<CR>',
        { noremap = true, silent = true },
      },
      {
        "<leader>dl",
        '<cmd>lua require"dap".run_last()<CR>',
        { noremap = true, silent = true },
      },
      {
        "<leader>du",
        '<cmd>lua require"dapui".toggle()<CR>',
        { noremap = true, silent = true },
      },
      {
        "<leader>de",
        '<cmd>lua require"dapui".eval()<CR>',
        { noremap = true, silent = true },
      },
      {
        "<leader>dd",
        '<cmd>lua require"dap".disconnect()<CR>',
        { noremap = true, silent = true },
      },
    },
  },
}
