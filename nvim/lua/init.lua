-- filetype
require("filetype").setup({
    overrides = {
        literal = {
            vimrc = "vim",
            gitconfig = "gitconfig",
        },
        complex = {
            ["^[^.]*$"] = "sh"
        }
    }
})
