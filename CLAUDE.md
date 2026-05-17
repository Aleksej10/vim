# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration targeting Neovim v0.12 with tree-sitter v0.26. Written entirely in Lua.

## Architecture

Entry point is `init.lua`, which loads three config modules in order:

1. `lua/config/default.lua` -- Core vim options, keymaps, autocmds, filetype detection
2. `lua/config/lazy.lua` -- Bootstraps lazy.nvim plugin manager (installed to `lazy/` inside config dir, not the default data dir)
3. `lua/config/lang.lua` -- Insert-mode leader mappings for special characters (Croatian, German, French, Italian)

Plugins live in `lua/plugins/`, one file per plugin (or plugin group). lazy.nvim auto-imports via `{ import = "plugins" }`.

## Key conventions

- Leader key is `,`
- Alt (A-) and Command (D-) are both mapped as modifiers via `mod_map()` helper in default.lua
- `jk` is mapped to ESC in insert mode
- C-i/C-o are swapped (C-i goes back, C-o goes forward)
- Split navigation uses C-h/j/k/l in normal, visual, and terminal modes
- Tab navigation uses Alt/Cmd + i/o (prev/next) and Alt/Cmd + 1-9,0

## LSP setup

LSP is configured in `lua/plugins/lsp.lua` using native `vim.lsp.config()` and `vim.lsp.enable()` (Neovim 0.12 style). Custom server configs (vscode-langservers, bundle_solargraph, ruff) are defined inline. All servers get cmp_nvim_lsp capabilities via the wildcard `vim.lsp.config('*', ...)` call.

Active servers: ty, ruff, rust_analyzer, bundle_solargraph, gopls, clangd, ts_ls, lua_ls, somesass_ls, kulala_ls, svelte, oxlint, vscode_css, vscode_html, vscode_json.

## Completion

nvim-cmp with vsnip snippet engine. Tab/S-Tab cycle completions, Right arrow confirms, Left arrow aborts.

## Debugging

DAP setup in `lua/plugins/debug.lua`. Currently configured for Python via debugpy. Breakpoint toggle is `<leader>bp`, debug commands use `<leader>d` prefix.

## Plugin install location

Plugins are installed to `~/.config/nvim/lazy/` (not the standard `~/.local/share/nvim/lazy/`). The `lazy/` directory is in the repo but contains third-party code -- do not edit files inside it.

## Testing changes

Open Neovim to test config changes. Use `:checkhealth` for diagnostics. Use `:Lazy` to manage plugins.
