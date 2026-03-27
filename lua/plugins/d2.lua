return {
  {
    "terrastruct/d2-vim",
    ft = { "d2" },
    dependencies = { "ravsii/tree-sitter-d2" },
    init = function()
      -- Enable/disable auto ASCII render on save (default: 1)
      vim.g.d2_ascii_autorender = 0

      -- Customize the ASCII render command (default: "d2")
      vim.g.d2_ascii_command = "d2"

      -- Set preview window width for vertical split (default: half screen)
      vim.g.d2_ascii_preview_width = vim.o.columns / 2

      -- Set ASCII mode: "extended" (Unicode) or "standard" (basic ASCII)
      vim.g.d2_ascii_mode = "standard"

      -- Commands
      -- :D2Preview - Render current buffer as ASCII in preview window
      -- :D2PreviewToggle - Toggle ASCII preview window on/off
      -- :D2PreviewUpdate - Update existing preview window with current content
      -- :D2PreviewCopy - Copy ASCII preview content to clipboard and yank register
      -- :D2PreviewSelection - Render selected text as ASCII (works in any file)
      -- :D2ReplaceSelection - Replace selected D2 code with ASCII render (works in any file)
      -- :D2AsciiToggle - Toggle automatic ASCII rendering on save

      -- Keybindings
      -- <Leader>d2 - Render selected text as ASCII (visual mode, any file)
      -- <Leader>d2 - Render entire buffer as ASCII (normal mode, D2 files only)
      -- <Leader>rd2 - Replace selected D2 code with ASCII render (visual mode, any file)
      -- <Leader>yd2 - Copy ASCII preview content to clipboard and yank register (normal mode, any file)

    end,
  },
  {
    "ravsii/tree-sitter-d2",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    version = "*", -- use the latest git tag instead of main
    build = "make nvim-install",
  },
}
