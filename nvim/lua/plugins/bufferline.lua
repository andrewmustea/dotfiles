-- bufferline.nvim
--

require("bufferline").setup {
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    numbers =
      function(opts)
        local winlist = vim.fn.win_findbuf(tonumber(opts.id))
        if next(winlist) then
          local tablist = vim.fn.win_id2tabwin(winlist[1])
          if next(tablist) then
            return ""
          end
        end
        return string.format("(%s)", opts.id)
      end,
    diagnostics = false,
    diagnostics_update_in_insert = false,
    diagnostics_indicator =
      function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
    offsets = {
      {
        filetype = "NvimTree",
        highlight = "Directory",
        text_align = "left"
      }
    },
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = "slant",
    sort_by = "tabs",
  }
}

-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
-- nnoremap <silent>[b :BufferLineCycleNext<CR>
-- nnoremap <silent>]b :BufferLineCyclePrev<CR>
vim.keymap.set("n", "[b", ":BufferLineCycleNext<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "]b", ":BufferLineCyclePrev<CR>", { silent = true, noremap = true })

-- These commands will move the current buffer backwards or forwards in the bufferline
vim.keymap.set("n", "<mymap>", ":BufferLineMoveNext<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<mymap>", ":BufferLineMovePrev<CR>", { silent = true, noremap = true })

-- These commands will sort buffers by directory, language, or a custom criteria
-- nnoremap <silent>be :BufferLineSortByExtension<CR>
-- nnoremap <silent>bd :BufferLineSortByDirectory<CR>
-- nnoremap <silent><mymap> :lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>

-- Buffer selection
vim.keymap.set("n", "gb", ":BufferLinePick<CR>", { silent = true, noremap = true })

vim.keymap.set("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { silent = true, noremap = true })
