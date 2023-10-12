-- filetype.lua
--

-- manually set filetypes
vim.filetype.add({
  filename = {
    [".luacheckrc"] = "lua",
    ["bashrc"] = "sh",
    ["env"] = "sh",
    ["gitconfig"] = "gitconfig",
    ["profile"] = "sh",
    ["vimrc"] = "vim"
  }
})

-- zsh files should use bash treesitter syntax
vim.treesitter.language.register("bash", "zsh")

