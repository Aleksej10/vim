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
  }
}
