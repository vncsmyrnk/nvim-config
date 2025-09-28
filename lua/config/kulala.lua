local M = {}

local current_pane_index = 1

-- uses kulala api to make a winbar tab active on the ui
---@param pane_index integer
local kulala_select_winbar_tab = function(pane_index)
  require("kulala.ui.winbar").select_winbar_tab(pane_index)
end

-- uses kulala api to get the default pane count
---@return integer
local kulala_default_pane_count = function()
  local panes_count = require("kulala.config").get().default_winbar_panes

  -- excludes the last help tab for now
  -- at this time it breaks when default ui keymaps are unset (false)
  return #panes_count - 1
end

-- selects the closest right pane on the kulala ui winbar
-- opens the fist one when triggered on the last one
function M.next_winbar_tab()
  local pane_count = kulala_default_pane_count()
  current_pane_index = current_pane_index + 1
  if current_pane_index > pane_count then
    current_pane_index = 1
  end
  kulala_select_winbar_tab(current_pane_index)
end

-- selects the closest left pane on the kulala ui winbar
-- opens the last one when triggered on the first one
function M.previous_winbar_tab()
  local pane_count = kulala_default_pane_count()
  current_pane_index = current_pane_index - 1
  if current_pane_index < 1 then
    current_pane_index = pane_count
  end
  kulala_select_winbar_tab(current_pane_index)
end

return M
