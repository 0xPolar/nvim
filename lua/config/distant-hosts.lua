local hosts = {
  {
    name = "Homelab - Proxmox",
    destination = "root@192.168.0.51:22",
    auth = "key",
    key = "~/.ssh/id_ed25519_homelab",
  },
  {
    name = "Media Server (LXC)",
    destination = "yams@10.10.10.10:22",
    auth = "key",
    key = "~/.ssh/id_ed25519_homelab",
  },
  -- { name = "Dev Box",            destination = "user@dev.example.com:22", auth = "password" },
}

local function connect_distant()
  local items = {}
  for i, h in ipairs(hosts) do
    items[i] = string.format("%d. %s  (%s) [%s]", i, h.name, h.destination, h.auth)
  end

  vim.ui.select(items, { prompt = "Connect to remote host:" }, function(_, idx)
    if not idx then
      return
    end
    local host = hosts[idx]

    local opts = {
      destination = "ssh://" .. host.destination,
    }
    if host.auth == "key" then
      local key_path = vim.fn.expand(host.key or "~/.ssh/id_ed25519")
      opts.options = { ["ssh.identity_files"] = key_path }
    end

    vim.notify("Connecting to " .. host.name .. "...", vim.log.levels.INFO)

    local distant = require("distant")
    distant.editor.connect(opts, function(err, _client)
      if err then
        vim.schedule(function()
          vim.notify("Connection failed: " .. tostring(err), vim.log.levels.ERROR)
        end)
        return
      end
      vim.schedule(function()
        vim.notify("Connected to " .. host.name, vim.log.levels.INFO)
        distant.editor.open({ path = "/home" })
      end)
    end)
  end)
end

local function browse_remote_dir()
  vim.ui.input({ prompt = "Remote directory: ", default = "/" }, function(dir)
    if not dir or dir == "" then
      return
    end
    local distant = require("distant")
    if not distant:active_client_id() then
      vim.notify("No active Distant connection. Use <leader>rc first.", vim.log.levels.WARN)
      return
    end
    local ok, err = pcall(distant.editor.open, { path = dir })
    if not ok then
      vim.notify("Failed to open: " .. tostring(err), vim.log.levels.ERROR)
    end
  end)
end

local function remote_shell()
  local distant = require("distant")
  if not distant:active_client_id() then
    vim.notify("No active Distant connection. Use <leader>rc first.", vim.log.levels.WARN)
    return
  end
  local ok, err = pcall(vim.cmd, "DistantShell")
  if not ok then
    vim.notify("Failed to open remote shell: " .. tostring(err), vim.log.levels.ERROR)
  end
end

vim.keymap.set("n", "<leader>rc", connect_distant, { desc = "Connect to remote host (Distant)" })
vim.keymap.set("n", "<leader>rb", browse_remote_dir, { desc = "Browse remote directory (Distant)" })
vim.keymap.set("n", "<leader>rt", remote_shell, { desc = "Open remote terminal (Distant)" })

local ok_wk, wk = pcall(require, "which-key")
if ok_wk then
  wk.add({ { "<leader>r", group = "remote (distant)" } })
end
