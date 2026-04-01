return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "nvim-telescope/telescope.nvim" },
    init = function()
      local telescope = require('telescope.builtin')

      local map = function(key, cmd)
        vim.keymap.set('n', key, cmd, { noremap = true, silent = true })
      end

      vim.diagnostic.config({
        virtual_text = true,
        virtual_lines = { current_line = true },
        underline = false,
        update_in_insert = false
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = "rounded",
          focusable = false, -- keeps you from accidentally jumping into the floating window
        }
      )

      local function toggle_diagnostics()
        vim.diagnostic.enable(not vim.diagnostic.is_enabled())
      end


      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          -- local client = vim.lsp.get_client_by_id(args.data.client_id)

          map('<leader>ge', toggle_diagnostics)

          map('K', vim.lsp.buf.hover) -- default

          map('gd', telescope.lsp_definitions) -- Go to definition
          -- map('gd', vim.lsp.buf.definition) -- Go to definition 

          map('gD', vim.lsp.buf.declaration)   -- Go to declaration

          map('gy', telescope.lsp_type_definitions)  -- Go to type definition
          -- map('gy', vim.lsp.buf.type_definition)  -- Go to type definition 

          map('gi', telescope.lsp_implementations)    -- Go to implementations
          -- map('gi', vim.lsp.buf.implementation)    -- Go to implementation

          map('cd', vim.lsp.buf.rename)        -- Rename (change definition)

          map('gA', telescope.lsp_references)     -- Go to All references to the current word
          -- map('gA', vim.lsp.buf.references)    -- Go to All references to the current word

          map('gs', vim.lsp.buf.document_symbol)  -- Find symbol in current file

          map('gS', telescope.lsp_dynamic_workspace_symbols) -- Find symbol in entire project
          -- map('gS', vim.lsp.buf.workspace_symbol)         -- Find symbol in entire project

          -- map('<C-k>', vim.lsp.buf.signature_help) -- Signature help -- this should auto-open

          map('gI', telescope.lsp_incoming_calls) -- List what's calling the symbol
          map('gO', telescope.lsp_outgoing_calls) -- List what the function is calling


          map('<leader>fm', vim.lsp.buf.format) -- Format a buffer using attached LSP
          map('<leader>fd', telescope.diagnostics) -- Show diagnostics

          -- TODO: pass OPTIONS
          map('g.', vim.lsp.buf.code_action)  -- Open the code actions menu


          vim.diagnostic.enable(false)
        end
      })

      vim.lsp.config['vscode_css'] = {
        cmd = { 'vscode-css-language-server', '--stdio' },
        filetypes = { 'css', 'scss', 'sass' },
      }

      vim.lsp.config['vscode_html'] = {
        cmd = { 'vscode-html-language-server', '--stdio' },
        filetypes = { 'html' },
      }

      vim.lsp.config['vscode_js'] = {
        cmd = { 'vscode-eslint-language-server', '--stdio' },
        filetypes = { 'javascript' },
      }

      vim.lsp.config['vscode_json'] = {
        cmd = { 'vscode-json-language-server', '--stdio' },
        filetypes = { 'json' },
      }

      vim.lsp.config['bundle_solargraph'] = {
        cmd = { 'bundle', 'exec', 'solargraph', 'stdio' },
        filetypes = { 'ruby' },
      }

      vim.lsp.config('*', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        root_markers = { '.git' },
        -- root_dir = require('lspconfig.util').root_pattern('.git'),
        on_attach = function(client, bufnr)
          client.server_capabilities.semanticTokensProvider = true
        end,
      })


      local servers = { 
        -- 'basedpyright',
        'ty',
        'rust_analyzer', 
        'bundle_solargraph',
        'gopls', 
        'clangd',

        'ts_ls', 
        'lua_ls',
        'somesass_ls',

        'oxlint',
        -- 'vscode_js',
        'vscode_css',
        'vscode_html',
        'vscode_json',
      }

      for _, server in pairs(servers) do
        vim.lsp.enable(server)
      end
    end,
  }
}
