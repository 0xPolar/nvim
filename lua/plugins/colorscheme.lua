return {
  -- add your preferred colorscheme
  { "catppuccin/nvim", name = "catppuccin", opts = { flavour = "mocha" } },

  -- tell LazyVim to use it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
