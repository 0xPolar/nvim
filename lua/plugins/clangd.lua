return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.clangd = opts.servers.clangd or {}

      local cmd = opts.servers.clangd.cmd or { "clangd" }
      opts.servers.clangd.cmd = cmd

      local query_driver = "--query-driver=C:/msys64/mingw64/bin/g++.exe,C:/msys64/mingw64/bin/x86_64-w64-mingw32-g++.exe"
      if not vim.tbl_contains(cmd, query_driver) then
        table.insert(cmd, query_driver)
      end
    end,
  },
}
