return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local treesitter_status = {
        function()
          local buf = vim.api.nvim_get_current_buf()
          if vim.treesitter.highlighter.active[buf] then
            return "󰐅"
          end
          return ""
        end,
        color = { fg = '#007d32' },
      }

      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'auto',
          globalstatus = (vim.o.laststatus == 3),
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
            refresh_time = 16, -- ~60fps
            events = {
              'WinEnter',
              'BufEnter',
              'BufWritePost',
              'SessionLoadPost',
              'FileChangedShellPost',
              'VimResized',
              'Filetype',
              'CursorMoved',
              'CursorMovedI',
              'ModeChanged',
            },
          }
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {
            { 'lsp_status', color = { bg = '#007d32' } },
            treesitter_status,
            'encoding',
            -- 'fileformat', 
            'filetype'
          },
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { 'fzf', 'fugitive', 'nvim-dap-ui', 'nvim-tree' }
      })
    end,
  }
}
