---@return "dark" | "light"
local gcurmod = function()
  if vim.g.background == "dark" or vim.g.background == "light" then
    return vim.g.background
  else
    return "dark"
  end
end

local M = {}
M.color = require("clrtheme.color")
M.get_current_mode = gcurmod

M.__z = require("clrtheme.color").colors(gcurmod())
M.__g = require("clrtheme.groups").load(M.__z)

---Configure theme and install theme into instance
M.setup = function()
  print("setting up")
  vim.g.colors_name = "clrtheme"
  vim.cmd("hi clear")
  vim.cmd("syntax reset")
  ---@type table
  M.__g = require("clrtheme.groups").load(M.__z)

  for k, v in pairs(M.__g) do
    vim.api.nvim_set_hl(0, k, v)
  end

  -- vim.cmd("hi Normal guibg=" .. M.gcol("bg"))
end

function M.load_feline()
  local theme = {
    red = M.color.gcol("red"),
    green = M.color.gcol("green"),
    blue = M.color.gcol("blue"),
    gray = M.color.gcol("bg"),
    fg = M.color.gcol("linefg"),
    bg = M.color.gcol("linebg"),
    n = M.color.gcol("normal"),
    v = M.color.gcol("visual"),
    i = M.color.gcol("insert"),
    c = M.color.gcol("command"),
  }
  require("feline").use_theme(theme)
end

function M.lualine_theme()
  return {
    normal = {
      a = { bg = M.color.gcol("green"), fg = M.color.gcol("fg"), gui = "bold" },
      b = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg") },
      c = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg") },
      z = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg") },
    },
    insert = {
      a = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg"), gui = "bold" },
      b = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg") },
      c = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg") },
    },
    visual = {
      a = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg"), gui = "bold" },
      b = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg") },
      c = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg") },
    },
    replace = {
      a = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg"), gui = "bold" },
      b = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg") },
      c = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg") },
    },
    command = {
      a = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg"), gui = "bold" },
      b = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg") },
      c = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg") },
    },
    inactive = {
      a = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg"), gui = "bold" },
      b = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg") },
      c = { bg = M.color.gcol("linebg"), fg = M.color.gcol("fg") },
    },
  }
end

function M.load_lualine()
  require("lualine").setup({ options = { theme = M.lualine_theme() } })
end

function M.bufferline_highlights()
  local norm_bg = M.color.gcol("bg")
  local norm_fg = M.color.gcol("fg")
  local comment_fg = M.color.gcol("comments")
  local black = M.color.gcol("black")
  local visible = M.color.gcol("dark_gray")

  -- The backdrop color
  local backdrop = black

  return {
    fill = {
      fg = norm_bg,
      bg = backdrop,
    },
    background = {
      fg = comment_fg,
      bg = visible,
    },
    tab = {
      fg = comment_fg,
      bg = visible,
    },
    tab_selected = {
      fg = norm_fg,
      bg = norm_bg,
    },
    tab_close = {
      fg = comment_fg,
      bg = norm_bg,
    },
    close_button = {
      fg = norm_fg,
      bg = visible,
    },
    close_button_selected = {
      fg = norm_fg,
      bg = norm_bg,
    },
    numbers = {
      fg = comment_fg,
      bg = visible,
    },
    numbers_selected = {
      fg = norm_fg,
      bg = norm_bg,
      bold = true,
      italic = true,
    },
    separator_selected = {
      fg = backdrop,
      bg = norm_bg,
    },
    separator = {
      fg = backdrop,
      bg = visible,
    },
    pick = {
      bg = norm_bg,
      bold = true,
      italic = true,
    },
    offset_separator = {
      bg = norm_bg,
    },
  }
end

return M
