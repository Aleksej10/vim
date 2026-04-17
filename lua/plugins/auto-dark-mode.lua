return {
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = function()
        vim.g.autodark_background = "dark"
        vim.o.background = "dark"
      end,
      set_light_mode = function()
        vim.g.autodark_background = "light"
        vim.o.background = "light"
      end,
      update_interval = 3000,
      fallback = "dark"
    }
  }
}
