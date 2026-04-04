return {
  {
    "preservim/vim-markdown",
    dependencies = { "godlygeek/tabular" },
    init = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_conceal = 0
      vim.g.tex_conceal = ""
      vim.g.vim_markdown_math = 1
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function()
      local md = require('render-markdown')

      vim.keymap.set('n', '<leader>md', md.toggle, { noremap = true, silent = true })

      md.setup({
        completions = { lsp = { enabled = true } },
      })
    end,
  }
}
