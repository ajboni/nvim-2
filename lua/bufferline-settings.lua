require("bufferline").setup({
  options = {
    right_mouse_command = "vertical sbuffer %d",
    offsets = {
      {
        filetype = "NvimTree",
        -- text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },
    diagnostics = "nvim_lsp",
    max_name_length = 22,
    tab_size = 22,
  },
})
