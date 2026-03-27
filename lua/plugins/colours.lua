return {
  {
    "rrethy/vim-hexokinase",
    build = 'make hexokinase',
    init = function()
      vim.opt.termguicolors = true
      vim.g.Hexokinase_highlighters = { "backgroundfull" }
      vim.g.Hexokinase_optInPatterns = "full_hex,rgb,rgba,hsl,hsla,colour_names"
      vim.keymap.set("n", "<leader>tc", ":HexokinaseToggle<CR>", { silent = true })
    end,
  }
}
