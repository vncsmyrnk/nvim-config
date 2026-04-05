---@class TabLine
local M = {}

--- returns a valid string to be set as neovim's tabline
--- it display the cwd folder name
---@return string
function M.render()
  ---@type string
  local s = ""

  for i = 1, vim.fn.tabpagenr("$") do
    if i == vim.fn.tabpagenr() then
      s = s .. "%#TabLineSel#"
    else
      s = s .. "%#TabLine#"
    end

    -- allow clicking tabs with the mouse
    s = s .. "%" .. i .. "T"

    ---@type string
    local tab_cwd = vim.fn.getcwd(0, i)

    -- e.g., "/Users/name/Projects/todo" becomes "todo"
    ---@type string
    local folder_name = vim.fn.fnamemodify(tab_cwd, ":t")

    -- fallback if we are somehow at the root directory
    if folder_name == "" then
      folder_name = "/"
    end

    s = s .. " " .. i .. ": " .. folder_name .. " "
  end

  -- fill the rest of the empty space with the default background color
  s = s .. "%#TabLineFill#%T"
  return s
end

return M
