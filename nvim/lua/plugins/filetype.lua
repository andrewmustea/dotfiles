-- filetype.nvim
--

require("filetype").setup({
  overrides = {
    literal = {
      ["env"] = "sh",
      ["gitconfig"] = "gitconfig",
      [".luacheckrc"] = "lua",
      ["profile"] = "sh",
      ["vimrc"] = "vim"
    }
  }
})

