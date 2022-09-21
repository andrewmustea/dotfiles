-- lualine.nvim
--

local bo = vim.bo
local status_color = nil

local function file_status()
  if bo.modifiable == false or bo.readonly == true then
    status_color = { fg = "#b02828" }
    return "[-]"
  elseif bo.modified then
    status_color = { fg = "#0040bb" }
    return "[+]"
  end
  status_color = nil
  return ""
end

local function get_color()
  return status_color
end

require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "black_sun",
    component_separators = { left = "|", right = "|" },
    section_separators = "",
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      { "filename",
        file_status = false,
        newfile_status = false,
        path = 1,
        separator = ""
      },
      { file_status,
        color = get_color,
        separator = { left = "", right = "|" },
        padding = { left = 0, right = 1 }
      },
    },
    lualine_x = { "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" }
  },
  inactive_sections = {
    lualine_a = { },
    lualine_b = { },
    lualine_c = {
      { "filename",
        file_status = false,
        newfile_status = false,
        path = 1,
        separator = ""
      },
      { file_status,
        color = get_color,
        separator = { left = "", right = "|" },
        padding = { left = 0, right = 1 }
      },
    },
    lualine_x = { "location" },
    lualine_y = { },
    lualine_z = { }
  },
  extensions = { "nvim-tree" }
}

