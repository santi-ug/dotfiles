local function show_all_diffview_context()
  if vim.g.diffview_show_all_context == nil then
    vim.g.diffview_show_all_context = false
  end

  return vim.g.diffview_show_all_context
end

local function apply_diffview_context_folds()
  local foldenable = not show_all_diffview_context()

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.wo[win].diff then
      vim.wo[win].foldenable = foldenable
    end
  end
end

local function toggle_diffview_context()
  vim.g.diffview_show_all_context = not show_all_diffview_context()
  apply_diffview_context_folds()

  local state = vim.g.diffview_show_all_context and 'expanded' or 'folded'
  vim.notify('Diffview context lines: ' .. state)
end

return {
  'sindrets/diffview.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  cmd = {
    'DiffviewOpen',
    'DiffviewClose',
    'DiffviewToggleFiles',
    'DiffviewFocusFiles',
    'DiffviewRefresh',
    'DiffviewFileHistory',
  },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = '[G]it [D]iff working tree' },
    { '<leader>gD', '<cmd>DiffviewOpen --cached<CR>', desc = '[G]it [D]iff staged changes' },
    { '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', desc = '[G]it file [H]istory' },
    { '<leader>gH', '<cmd>DiffviewFileHistory<CR>', desc = '[G]it repo [H]istory' },
    { '<leader>gq', '<cmd>DiffviewClose<CR>', desc = '[G]it close diffview' },
    { '<leader>gc', toggle_diffview_context, desc = '[G]it toggle diffview [C]ontext' },
  },
  init = function()
    vim.api.nvim_create_user_command('DiffviewToggleContext', toggle_diffview_context, {})
  end,
  opts = function()
    local actions = require 'diffview.actions'
    return {
    enhanced_diff_hl = true,
    hooks = {
      diff_buf_win_enter = function()
        vim.opt_local.foldenable = not show_all_diffview_context()
      end,
    },
    view = {
      default = {
        layout = 'diff2_horizontal',
      },
      merge_tool = {
        layout = 'diff3_horizontal',
        disable_diagnostics = true,
      },
      file_history = {
        layout = 'diff2_horizontal',
      },
    },
    file_panel = {
      listing_style = 'tree',
      tree_options = {
        flatten_dirs = true,
        folder_statuses = 'only_folded',
      },
      win_config = {
        position = 'left',
        width = 35,
      },
    },
    file_history_panel = {
      win_config = {
        position = 'bottom',
        height = 16,
      },
    },
    keymaps = {
      file_panel = {
        { 'n', '-', false },
        { 'n', '<leader>gS', actions.toggle_stage_entry, { desc = '[G]it [S]tage/unstage file' } },
        { 'n', '<leader>gU', actions.toggle_stage_entry, { desc = '[G]it [U]nstage/stage file' } },
      },
    },
  }
  end,
}
