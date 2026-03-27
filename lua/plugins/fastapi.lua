return {
  {
    "mrpbennett/nimbleapi.nvim",
    cmd = "NimbleAPI",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "mistweaverco/kulala.nvim",
    },
    init = function()
      local nimble = require('nimbleapi')

      nimble.setup({
        provider = 'fastapi', 

        explorer = {
          position = "left",
          width = 40,
          icons = true,
        },

        picker = {
          provider = "telescope",
        },

        keymaps = {
          toggle   = "<leader>Nt", -- toggle explorer sidebar
          pick     = "<leader>Np", -- open route picker
          refresh  = "<leader>Nr", -- refresh route cache
          codelens = "<leader>Nc", -- toggle codelens

          http_run     = "<leader>Ns", -- send request
          http_replay  = "<leader>NR", -- replay last request
          http_inspect = "<leader>Ni", -- inspect current request
          http_env     = "<leader>NE", -- set environment
        },

        codelens = {
          enabled = true,
          test_patterns = { "test_*.py", "*_test.py", "tests/**/*.py" },
        },

        watch = {
          enabled = true,
          debounce_ms = 200,
        },
      })

      vim.keymap.set('n', '<leader>Nt', nimble.explorer, { silent = true })
    end,
  }
}
