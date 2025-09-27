local CONFIG = require("kulala.config")
local WINBAR = require("kulala.ui.winbar")

local M = {}

local current_pane_index = 1
local default_panes = CONFIG.get().default_winbar_panes

-- excludes the last help tab for now
-- at this time it breaks when default ui keymaps are unset (false)
local panes_count = #default_panes - 1

local select_current_winbar_tab = function()
  WINBAR.select_winbar_tab(current_pane_index)
end

-- selects the closest right pane on the kulala ui winbar
-- opens the fist one when triggered on the last one
function M.next_winbar_tab()
  current_pane_index = current_pane_index + 1
  if current_pane_index > panes_count then
    current_pane_index = 1
  end
  select_current_winbar_tab()
end

-- selects the closest left pane on the kulala ui winbar
-- opens the last one when triggered on the first one
function M.previous_winbar_tab()
  current_pane_index = current_pane_index - 1
  if current_pane_index < 1 then
    current_pane_index = panes_count
  end
  select_current_winbar_tab()
end

return M
