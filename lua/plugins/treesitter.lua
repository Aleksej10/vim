return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    init = function()
      local parser_path = vim.fn.stdpath('config') .. '/treesitter'

      if vim.fn.isdirectory(parser_path) == 0 then
        vim.fn.mkdir(parser_path, "p")
      end

      vim.opt.runtimepath:append(parser_path)

      local languages = {
          'bash',
          'go',
          'gomod',
          'gosum',
          'gotmpl',
          'haskell',
          'c',
          'cpp',
          'cmake',
          'csv',
          'make',
          'dockerfile',
          'git_config',
          'gitignore',
          'lua',
          'latex',
          'python',
          'ruby',
          'rust',
          'typescript',
          'javascript',
          'nginx',
          'html',
          'css',
          'scss',
          'zig',
          'sql',
          'json',
          'jsx',
          'tsx',
          'toml',
          'vim',
          'vimdoc',
          'svelte',
          'yaml',
          'zsh',
        },

      require('nvim-treesitter').install(languages)

      require('nvim-treesitter').setup({
        install_dir = parser_path,
        ensure_installed = languages,
        sync_install = true,
        ignore_install = { },
        highlight = {
          enable = true,
          disable = { },
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })

      local excluded = { 'nimbleapi-explorer' }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = '*',
        callback = function()
          if vim.tbl_contains(excluded, vim.bo.filetype) then
            return
          end
          pcall(vim.treesitter.start)
        end,
      })
    end,
  }
}
