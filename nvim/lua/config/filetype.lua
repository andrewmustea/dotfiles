-- filetype.nvim
--

require("filetype").setup({
  overrides = {
    literal = {
      [".luacheckrc"] = "lua",
      ["bashrc"] = "sh",
      ["env"] = "sh",
      ["gitconfig"] = "gitconfig",
      ["profile"] = "sh",
      ["vimrc"] = "vim"
    }
  }
})

