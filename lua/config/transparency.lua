local M = {}

local state_file = vim.fn.stdpath("state") .. "/transparency"
local opaque_pumblend = vim.o.pumblend
local default_enabled = true

local function read_state()
  if vim.fn.filereadable(state_file) == 0 then
    return default_enabled
  end

  local ok, lines = pcall(vim.fn.readfile, state_file)
  if not ok or not lines[1] then
    return default_enabled
  end

  if lines[1] == "enabled" then
    return true
  elseif lines[1] == "disabled" then
    return false
  end

  return default_enabled
end

local enabled = read_state()

local function set_options(opts, state)
  opts.transparent_background = state
  opts.float = opts.float or {}
  opts.float.transparent = state
  return opts
end

local function write_state(state)
  local ok, result = pcall(function()
    vim.fn.mkdir(vim.fn.fnamemodify(state_file, ":h"), "p")
    return vim.fn.writefile({ state and "enabled" or "disabled" }, state_file)
  end)

  if not ok or result == -1 then
    vim.notify("Could not save the transparency preference", vim.log.levels.ERROR)
  end
end

function M.configure(opts)
  vim.o.pumblend = enabled and 0 or opaque_pumblend
  return set_options(opts, enabled)
end

function M.get()
  return enabled
end

function M.set(state)
  local catppuccin = require("catppuccin")
  local opts = set_options(vim.deepcopy(catppuccin.options), state)
  local previous_pumblend = vim.o.pumblend

  vim.o.pumblend = state and 0 or opaque_pumblend
  local ok, err = pcall(function()
    catppuccin.setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end)

  if not ok then
    vim.o.pumblend = previous_pumblend
    error(err)
  end

  enabled = state
  write_state(state)
end

return M
