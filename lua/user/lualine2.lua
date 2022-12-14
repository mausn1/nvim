local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end



local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic", "nvim_lsp" },
	sections = { "error", "warn"},
	--[[ sections = { "error", "warn", "info", "hint"}, ]]
	symbols = { error = "E:", warn = "W:"},
	--[[ symbols = { error = " ", warn = " ", info = " ", hint = " " }, ]]
	colored = true,
	update_in_insert = false,
	always_visible = false,
}


local diff = {
	"diff",
	colored = true,
	symbols = { added = "+ ", modified = "~ ", removed = "- " }, -- changes diff symbols
	--symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width
}

local mode = {
	"mode",
	fmt = function(str)
		return " " .. str .. " "
	end,
}

local filename = {
  "filename",
  path= 0,
}

local filetype = {
	"filetype",
	icons_enabled = true,
	--icon = nil,
  colored = false,
}

local fileformat = {
	"fileformat",
  fmt = string.upper,
	icons_enabled = false,
	--icon = nil,
  colored = false,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
  --If weird prob cuz this
	padding = 2,
}

-- cool function for progress
local progress = function()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "  ", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "│", right = "│" },
		section_separators = { left = "", right = "" },
		--[[ section_separators = { left = "", right = "" }, ]]
		disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { branch},
		lualine_c = { diagnostics, filename },
	  --lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { diff, fileformat ,filetype },
		lualine_y = { location },
		lualine_z = { progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
