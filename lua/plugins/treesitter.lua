return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local parser_path = vim.fn.stdpath('config') .. '/treesitter'

      if vim.fn.isdirectory(parser_path) == 0 then
        vim.fn.mkdir(parser_path, "p")
      end

      vim.opt.runtimepath:prepend(parser_path)

      local languages = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "css",
        "csv",
        "d2",
        "dockerfile",
        "git_config",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "haskell",
        "html",
        "hyprlang",
        "javascript",
        "json",
        "jsx",
        "latex",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "nginx",
        "python",
        "ruby",
        "rust",
        "scss",
        "sql",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "zig",
        "zsh",
      },

      require('nvim-treesitter').setup({
        install_dir = parser_path,
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

      require('nvim-treesitter').install(languages):wait(300000)

      local excluded = { 
        'nimbleapi-explorer',
        'NvimTree',
      }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = '*',
        callback = function()
          if vim.tbl_contains(excluded, vim.bo.filetype) then
            return
          end
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldmethod = 'expr'
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          pcall(vim.treesitter.start)
        end,
      })
    end,
  }
}
