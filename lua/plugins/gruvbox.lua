return {
  -- the colorscheme should be available when starting Neovim
  {
    "morhetz/gruvbox",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
      vim.g.gruvbox_bold = 1
      vim.g.gruvbox_italic = 1
      vim.g.gruvbox_contrast_dark = "dark"
      vim.g.gruvbox_transparent_bg = 1
      vim.g.gruvbox_underline = 1
      vim.g.gruvbox_undercurl = 1
      vim.g.gruvbox_termcolors = 1
      vim.g.gruvbox_italicize_comments = 1
      vim.g.gruvbox_italicize_strings = 0
      vim.g.gruvbox_sign_column = "bg0"

      local function make_transparent()
        -- set fillchars+=vert:\
        vim.cmd.highlight("Normal                ctermbg=None guibg=None")
        vim.cmd.highlight("LineNr                ctermbg=None guibg=None")
        -- vim.cmd.highlight("CursorLineNr          term=bold    cterm=bold guibg=#ff7900")
        vim.cmd.highlight("SignColumn            ctermbg=None guibg=None")
        vim.cmd.highlight("StatusLineNC          guifg=None   guibg=None")
        vim.cmd.highlight("VertSplit             guifg=None   guibg=None")
        vim.cmd.highlight("CursorLine            term=bold    cterm=bold")
        vim.cmd.highlight("TabLine               guibg=None")
        vim.cmd.highlight("TabLineFill           guibg=None")
        vim.cmd.highlight("TabLineFill           term=bold    cterm=bold guibg=None")
        -- vim.cmd.highlight("NvimTreeStatusLine    guibg=None")
        -- vim.cmd.highlight("NvimTreeStatusLineNC  guibg=None")
      end

      vim.o.bg = "dark"
      vim.cmd.colorscheme("gruvbox")
      make_transparent()

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = make_transparent,
      })
    end,
  },
}
