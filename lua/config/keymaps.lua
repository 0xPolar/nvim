-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
require("config.distant-hosts")

local transparency = require("config.transparency")
local transparency_toggle = Snacks.toggle({
  name = "Transparency",
  get = transparency.get,
  set = transparency.set,
})

transparency_toggle:map("<leader>uO")
vim.api.nvim_create_user_command("TransparencyToggle", function()
  transparency_toggle:toggle()
end, { desc = "Toggle Neovim transparency" })
