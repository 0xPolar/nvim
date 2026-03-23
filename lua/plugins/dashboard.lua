return {
  "nvimdev/dashboard-nvim",
  opts = function(_, opts)
    local logo = [[

 ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
 ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ 
▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░
   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   
         ░    ░  ░    ░ ░        ░   ░         ░   
                                ░                  
    ▄  ▄              ▄     ▄          ▄        ▄  
    █  █              █     █          █        █  
    █  ▀  ▄    ▄      █     ▀   ▄      █   ▄    █  
    █     █    █      ▀         █      ▀   █    ▀  
    ▀     █    ▀                █          █       
          ▀    ▄                ▀          ▀       
               █                                   
               ▀                                   
    ]]
    logo = string.rep("\n", 8) .. logo .. "\n\n"
    opts.config.header = vim.split(logo, "\n")
  end,
  config = function(_, opts)
    require("dashboard").setup(opts)

    -- Blood red highlights for the drip effect
    vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#b91c1c" })

    -- Optional: gradient drip effect using multiple highlight groups
    -- Uncomment and use with a custom render if you want per-line color
    -- vim.api.nvim_set_hl(0, "DashboardBlood1", { fg = "#dc2626" })
    -- vim.api.nvim_set_hl(0, "DashboardBlood2", { fg = "#b91c1c" })
    -- vim.api.nvim_set_hl(0, "DashboardBlood3", { fg = "#991b1b" })
    -- vim.api.nvim_set_hl(0, "DashboardBlood4", { fg = "#7f1d1d" })
  end,
}
