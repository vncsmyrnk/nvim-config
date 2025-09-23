return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
      local ensure_installed = { "lua-language-server", "stylua", "shfmt", "nixfmt" }
      local mason_registry = require("mason-registry")
      for _, tool in ipairs(ensure_installed) do
        local package = mason_registry.get_package(tool)
        if not package:is_installed() then
          package:install()
        end
      end
    end,
  },
}
