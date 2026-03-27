return {
  {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- optional but recommended
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    init = function()
      local telescope = require('telescope.builtin')

      local map = function(key, cmd)
        vim.keymap.set('n', key, cmd, { noremap = true, silent = true, buffer = bufnr })
      end

      map('<leader>ff', telescope.find_files)
      map('<leader>fg', telescope.live_grep)
      map('<leader>fb', telescope.buffers)
      map('<leader>fh', telescope.help_tags)


      -- <C-x> open in split
      -- <C-v> open in vsplit
      -- <C-t> open in new tab
    end,
  }
}
