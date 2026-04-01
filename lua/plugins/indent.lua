return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    cond = not vim.g.vscode,
    init = function()
      -- vim.opt.listchars:append("space:⋅")
      -- vim.opt.listchars:append("eol:↴")
      vim.keymap.set("n", "<leader>i", "<cmd>IBLToggle<cr>", { silent = true })
    end,
    config = function()
      require("ibl").setup {
        indent = {
          char = "│",
        },
        scope = {
          enabled = true,
          show_start = true,
          show_end = false,
        },
      }
    end,
  }
}
