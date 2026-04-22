return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/vim-vsnip-integ",
    },
    init = function()
      vim.opt.completeopt = { "menu", "menuone", "noselect" }
    end,
    config = function()
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end

      local border_window = {                                                                                                                                                                                                            
        completion = {                                                                                                                                                                                             
          border = "rounded",                                                                                                                                                                                         
          col_offset = 0,                                                                                                                                                                                          
          scrollbar = true,                                                                                                                                                                                        
          scrolloff = 0,                                                                                                                                                                                           
          side_padding = 1,                                                                                                                                                                                        
          winblend = 0,                                                                                                                                                                                            
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",                                                                                                                    
          zindex = 1001                                                                                                                                                                                            
        },                                                                                                                                                                                                         
        documentation = {                                                                                                                                                                                          
          border = "rounded",                                                                                                                                                                                         
          col_offset = 0,                                                                                                                                                                                          
          max_height = 33,                                                                                                                                                                                         
          max_width = 115,                                                                                                                                                                                         
          scrollbar = true,                                                                                                                                                                                        
          scrolloff = 0,                                                                                                                                                                                           
          side_padding = 1,                                                                                                                                                                                        
          winblend = 0,                                                                                                                                                                                            
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",                                                                                                                    
          zindex = 1001                                                                                                                                                                                            
        }                                                                                                                                                                                                          
      }  

      local cmp = require('cmp')

      cmp.setup({
        snippet = {
          --  REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          end,
        },

        window = {
          completion = border_window,
          documentation = border_window,
        },

        mapping = cmp.mapping.preset.insert({
          -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Left>'] = cmp.mapping.abort(),
          -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<Right>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

          ['<Tab>'] = function(fallback)
            if not cmp.select_next_item() then
              if vim.bo.buftype ~= 'prompt' and has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end
          end,

          ['<C-k>'] = cmp.mapping(function()
            if cmp.visible() then
              cmp.close()
            end
            vim.lsp.buf.signature_help()
          end, { 'i', 's' }),

          ['<S-Tab>'] = function(fallback)
            if not cmp.select_prev_item() then
              if vim.bo.buftype ~= 'prompt' and has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end
          end,
        }),

        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'vsnip' },
          { 
            name = 'buffer',
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end
            }
          },
          { name = 'path' },
        }),

        experimental = {
          ghost_text = true
        },
      })

    end
  }
}
