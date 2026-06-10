return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "astro",
        "tsx",
        "typescript",
        "javascript",
        "css",
        "html",
        "markdown",
        "markdown_inline",
        "mdx",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        astro = {},
        tailwindcss = {
          filetypes = {
            "astro",
            "html",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "mdx",
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        astro = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
        mdx = { "prettierd", "prettier" },
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown", "mdx" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
