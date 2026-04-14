return {
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = function()
        vim.g.autodark_background = "dark"
        vim.o.background = "dark"
        vim.notify("AUTO DARK MODE changed background to DARK")
      end,
      set_light_mode = function()
        vim.g.autodark_background = "light"
        vim.o.background = "light"
        vim.notify("AUTO DARK MODE changed background to LIGHT")
      end,
      update_interval = 3000,
      fallback = "dark"
    }
  }
}
