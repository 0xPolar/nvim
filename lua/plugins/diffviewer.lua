return {
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
    },
    keys = {
      { "<leader>gvo", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
      { "<leader>gvm", "<cmd>DiffviewOpen origin/main...HEAD<cr>", desc = "Diffview Against Main" },
      { "<leader>gvh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History" },
      { "<leader>gvH", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview Repo History" },
      { "<leader>gvq", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    },
  },
}
