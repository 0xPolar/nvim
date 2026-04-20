return {
  {
    "Freedzone/kerbovim",
    ft = "kerboscript",
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local configs = require("lspconfig.configs")
      if not configs.kls then
        configs.kls = {
          default_config = {
            cmd = { "kls", "--stdio" },
            filetypes = { "kerboscript" },
            root_dir = require("lspconfig.util").find_git_ancestor,
            settings = {},
          },
        }
      end
      opts.servers = opts.servers or {}
      opts.servers.kls = {}
    end,
  },
}
