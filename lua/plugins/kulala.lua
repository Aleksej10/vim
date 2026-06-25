return {
  {
    "mistweaverco/kulala.nvim",
    pin = true,
    commit = "069112264780c72e0b2f30433e6e1690291b02a5",
    ft = {"http", "rest"},
    opts = {
      default_env = "local",
      global_keymaps = true,
      global_keymaps_prefix = "<leader>R",
      kulala_keymaps_prefix = "",
      kulala_keymaps = {
        ["Previous tab"] = false,
        ["Next tab"] = false,
        ["Show verbose"] = {
          "gV",
          function() require("kulala.ui").show_verbose() end,
        },
      },
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
