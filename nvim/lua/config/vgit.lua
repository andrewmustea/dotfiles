-- vgit.nvim
--

require("vgit").setup {
  settings = {
    hls = {
      GitComment = {
        gui = nil,
        fg = "#505050",
        bg = nil,
        sp = nil,
        override = true
      }
    },
    scene = {
      diff_preference = "split"
    }
  }
}
