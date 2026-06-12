local M = {}

local function state_file(name)
  return vim.fn.stdpath 'state' .. '/' .. name
end

local function read_state(name)
  local path = state_file(name)

  if vim.fn.filereadable(path) == 0 then
    return nil
  end

  local lines = vim.fn.readfile(path)
  if #lines == 0 or lines[1] == '' then
    return nil
  end

  return lines[1]
end

local function write_state(name, value)
  vim.fn.mkdir(vim.fn.stdpath 'state', 'p')
  vim.fn.writefile({ tostring(value) }, state_file(name))
end

function M.apply_tab_size(size)
  size = tonumber(size)
  if not size then
    return
  end

  vim.opt.tabstop = size
  vim.opt.shiftwidth = size
  vim.opt.softtabstop = size
end

function M.load_tab_size(default)
  M.apply_tab_size(read_state 'tab-size' or default)
end

function M.pick_tab_size()
  vim.ui.select({ 2, 4, 8 }, {
    prompt = 'Tab size',
    format_item = function(size)
      return size .. ' spaces'
    end,
  }, function(size)
    if not size then
      return
    end

    M.apply_tab_size(size)
    write_state('tab-size', size)
    vim.notify('Tab size set to ' .. size)
  end)
end

function M.load_colorscheme()
  local colorscheme = read_state 'colorscheme'
  if colorscheme then
    pcall(vim.cmd.colorscheme, colorscheme)
  end
end

function M.save_colorscheme(colorscheme)
  if colorscheme and colorscheme ~= '' then
    write_state('colorscheme', colorscheme)
  end
end

return M
