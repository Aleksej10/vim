return {
  {
    "mistweaverco/kulala.nvim",
    ft = {"http", "rest"},
    opts = {
      default_env = "local",
      global_keymaps = true,
      global_keymaps_prefix = "<leader>R",
      kulala_keymaps_prefix = "",
    },
    init = function ()
      vim.filetype.add({
        extension = {
          ['http'] = 'http',
        },
      })
    end,
  }
}
