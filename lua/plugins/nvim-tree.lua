return {
  -- the colorscheme should be available when starting Neovim
  {
    "kyazdani42/nvim-tree.lua",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    -- priority = 1000,
    config = function()
      vim.keymap.set('n', '<C-n>',     ':NvimTreeToggle<CR>',   { silent = true })
      vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>', { silent = true })

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true

      local function open_nvim_tree(data)
        local real_file = vim.fn.filereadable(data.file) == 1
        local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

        if real_file and not no_name then
          require("nvim-tree.api").tree.toggle({
            focus = false
          })
        else
          require("nvim-tree.api").tree.toggle({
            focus = true
          })
        end
      end

      vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

      local function my_on_attach(bufnr)
        local api = require "nvim-tree.api"

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- local function opts(desc)
          --    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        -- end

        -- vim.keymap.set('n', '', api.tree.change_root_to_parent,  opts('Up'))

        -- custom mappings
        vim.keymap.set('n', 'o',    api.node.open.edit,       {  buffer = bufnr, noremap = true, silent = true, nowait = true })
        vim.keymap.set('n', '<CR>', api.node.open.edit,       {  buffer = bufnr, noremap = true, silent = true, nowait = true })
        vim.keymap.set('n', 't',    api.node.open.tab,        {  buffer = bufnr, noremap = true, silent = true, nowait = true })
        vim.keymap.set('n', 's',    api.node.open.vertical,   {  buffer = bufnr, noremap = true, silent = true, nowait = true })
        vim.keymap.set('n', 'i',    api.node.open.horizontal, {  buffer = bufnr, noremap = true, silent = true, nowait = true })
      end

      require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
        on_attach = my_on_attach,
        hijack_cursor = false,
        auto_reload_on_write = true,
        disable_netrw = false,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,
        root_dirs = {},
        prefer_startup_root = false,
        sync_root_with_cwd = false,
        reload_on_bufenter = false,
        respect_buf_cwd = false,
        select_prompts = false,
        sort = {
          sorter = "name",
          folders_first = true,
          files_first = false,
        },
        view = {
          centralize_selection = false,
          cursorline = true,
          debounce_delay = 15,
          side = "left",
          preserve_window_proportions = false,
          number = false,
          relativenumber = false,
          signcolumn = "yes",
          width = 30,
          float = {
            enable = false,
            quit_on_focus_loss = true,
            open_win_config = {
              relative = "editor",
              border = "rounded",
              width = 30,
              height = 30,
              row = 1,
              col = 1,
            },
          },
        },
        renderer = {
          add_trailing = true,
          group_empty = false,
          full_name = false,
          root_folder_label = ":~:s?$?/..?",
          indent_width = 2,
          special_files = { },
          symlink_destination = true,
          highlight_git = "none",
          highlight_diagnostics = "none",
          highlight_opened_files = "icon",
          highlight_modified = "none",
          highlight_bookmarks = "none",
          highlight_clipboard = "name",
          indent_markers = {
            enable = false,
            inline_arrows = true,
            icons = {
              corner = "└",
              edge = "│",
              item = "│",
              bottom = "─",
              none = " ",
            },
          },
          icons = {
            web_devicons = {
              file = {
                enable = true,
                color = true,
              },
              folder = {
                enable = false,
                color = true,
              },
            },
            git_placement = "before",
            modified_placement = "after",
            diagnostics_placement = "signcolumn",
            bookmarks_placement = "signcolumn",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
              modified = true,
              diagnostics = true,
              bookmarks = true,
            },
            glyphs = {
              default = "",
              symlink = "",
              bookmark = "󰆤",
              modified = "●",
              folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
        hijack_directories = {
          enable = true,
          auto_open = true,
        },
        update_focused_file = {
          enable = false,
          update_root = false,
          ignore_list = {},
        },
        system_open = {
          cmd = "",
          args = {},
        },
        git = {
          enable = true,
          show_on_dirs = true,
          show_on_open_dirs = true,
          disable_for_dirs = {},
          timeout = 400,
          cygwin_support = false,
        },
        diagnostics = {
          enable = true,
          show_on_dirs = false,
          show_on_open_dirs = true,
          debounce_delay = 50,
          severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
          },
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },
        modified = {
          enable = false,
          show_on_dirs = true,
          show_on_open_dirs = true,
        },
        filters = {
          git_ignored = false,
          dotfiles = false,
          git_clean = false,
          no_buffer = false,
          no_bookmark = false,
          custom = {},
          exclude = {},
        },
        live_filter = {
          prefix = "[FILTER]: ",
          always_show_folders = true,
        },
        filesystem_watchers = {
          enable = true,
          debounce_delay = 50,
          ignore_dirs = {},
        },
        actions = {
          use_system_clipboard = true,
          change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
          },
          expand_all = {
            max_folder_discovery = 300,
            exclude = {},
          },
          file_popup = {
            open_win_config = {
              col = 1,
              row = 1,
              relative = "cursor",
              border = "shadow",
              style = "minimal",
            },
          },
          open_file = {
            quit_on_open = false,
            eject = true,
            resize_window = true,
            window_picker = {
              enable = true,
              picker = "default",
              chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
              exclude = {
                filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                buftype = { "nofile", "terminal", "help" },
              },
            },
          },
          remove_file = {
            close_window = true,
          },
        },
        trash = {
          cmd = "gio trash",
        },
        tab = {
          sync = {
            open = false,
            close = false,
            ignore = {},
          },
        },
        notify = {
          threshold = vim.log.levels.INFO,
          absolute_path = true,
        },
        help = {
          sort_by = "key",
        },
        ui = {
          confirm = {
            remove = true,
            trash = true,
            default_yes = false,
          },
        },
        experimental = {},
        log = {
          enable = false,
          truncate = false,
          types = {
            all = false,
            config = false,
            copy_paste = false,
            dev = false,
            diagnostics = false,
            git = false,
            profile = false,
            watcher = false,
          },
        },
      } -- END_DEFAULT_OPTS
    end,
  },
}
