return {
  {
    "mistweaverco/kulala.nvim",
    ft = {"http", "rest"},
    opts = {
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
