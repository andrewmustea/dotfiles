-- lualine.nvim
--

local red = "#b02828"
local blue = "#0040bb"
local bo = vim.bo

local function modified()
  if bo.modified then
    return "[+]"
  end
  return ""
end

local function read_only()
  return "[-]"
end

require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "black_sun",
    component_separators = { left = "|", right = "|" },
    section_separators = "",
    disabled_filetypes = { },
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
      { modified,
        color = { fg = blue },
        separator = { left = "", right = "|" },
        padding = { left = 0, right = 1 },
        cond = function()
          return bo.modifiable
        end
      },
      { read_only,
        color = { fg = red },
        separator = { left = "", right = "|" },
        padding = { left = 0, right = 1 },
        cond = function()
          return bo.buftype == "help" or not bo.modifiable or bo.readonly
        end
      }
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
      { modified,
        color = { fg = blue },
        separator = { left = "", right = "|" },
        padding = { left = 0, right = 1 },
        cond = function()
          return bo.modifiable
        end
      },
      { read_only,
        color = { fg = red },
        separator = { left = "", right = "|" },
        padding = { left = 0, right = 1 },
        cond = function()
          return bo.buftype == "help" or not bo.modifiable or bo.readonly
        end
      }
    },
    lualine_x = { "location" },
    lualine_y = { },
    lualine_z = { }
  },
  extensions = { "nvim-tree" }
}

