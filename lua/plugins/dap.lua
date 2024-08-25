return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      {"williamboman/mason.nvim"},
      {"mfussenegger/nvim-dap"},
      {"jay-babu/mason-nvim-dap.nvim"},
    },
    config = function()
      local must_install = {}
      if vim.fn.executable("go") then
        table.insert(must_install, "delve")
      end

      require("mason").setup({})
      require("mason-nvim-dap").setup({
        ensure_installed = must_install,
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
        }
      })

      local dap = require("dap")
      require("dapui").setup()
      dap.set_log_level("TRACE")

      dap.adapters.delve = {
        type = 'server',
        port = '2345',
        executable = {
          command = 'dlv',
          args = {'dap', '-l', '127.0.0.1:2345'},
        }
      }

      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}"
        },
        {
          type = "delve",
          name = "Debug test",
          request = "launch",
          mode = "test",
          program = "${file}"
        },
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}"
        },
        {
          type = "delve",
          name = "Attach",
          request = "attach",
          mode = "remote",
          remotePath = "",
          port = "2345",
          host = "127.0.0.1",
        }
      }
    end,
    keys = {
      {"<F5>", "<cmd>lua require\"dap\".continue()<CR>", { noremap = true, silent = true, desc = "DAP: Continue" }},
      {"<F10>", "<cmd>lua require\"dap\".step_over()<CR>", { noremap = true, silent = true, desc = "DAP: Step over" }},
      {"<F11>", "<cmd>lua require\"dap\".step_into()<CR>", { noremap = true, silent = true, desc = "DAP: Step into" }},
      {"<F12>", "<cmd>lua require\"dap\".step_out()<CR>", { noremap = true, silent = true, desc = "DAP: Step out" }},
      {"<leader>b", "<cmd>lua require\"dap\".toggle_breakpoint()<CR>", { noremap = true, silent = true, desc = "DAP: Toggle breakpoint" }},
      {"<leader>B", "<cmd>lua require\"dap\".set_breakpoint(vim.fn.input(\"Breakpoint condition: \"))<CR>", { noremap = true, silent = true }},
      {"<leader>dr", "<cmd>lua require\"dap\".repl.open()<CR>", { noremap = true, silent = true, desc = "DAP: Open REPL" }},
      {"<leader>dl", "<cmd>lua require\"dap\".run_last()<CR>", { noremap = true, silent = true, desc = "DAP: Run last" }},
      {"<leader>du", "<cmd>lua require\"dapui\".toggle()<CR>", { noremap = true, silent = true, desc = "DAP: Toggle UI" }},
    },
  },
}
