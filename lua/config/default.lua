local o = vim.o
local g = vim.g
local opt = vim.opt
local map = vim.keymap.set
local env = vim.env

g.mapleader = ','

o.encoding = 'utf-8'
env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
o.termguicolors = true
o.viminfo = ''

-- o.cmdheight = 0
o.mouse = "a" -- enable mouse in all modes
o.clipboard = "unnamedplus" -- use system clipboard
o.number = true
o.hidden = true
o.swapfile = false
o.backup = false
o.writebackup = false
o.showcmd = true
o.wrap = false
o.cursorline = true
o.autoindent = true
o.ignorecase = true
o.smartcase = true
o.showmatch = true
o.visualbell = true
o.sidescrolloff = 7
o.scrolloff = 3
opt.shortmess:append("c") -- supress completition menu messages
o.wildmode = "longest:full,full"
o.showmode = false
o.synmaxcol = 250

-- vim.g.elite_mode = 1 -- used by some plugin, enable at will

-- Disables automatic commenting on newline:
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

o.listchars = "tab:->"
o.list = true

-- set guifont=hive:h12

-- Splits open at the bottom and right
o.splitbelow = true
o.splitright = true

-- Shortcutting split navigation
map({ "n", "v" }, "<C-h>", "<C-w>h")
map({ "n", "v" }, "<C-j>", "<C-w>j")
map({ "n", "v" }, "<C-k>", "<C-w>k")
map({ "n", "v" }, "<C-l>", "<C-w>l")

-- moves window to new tab
map({ "n", "v" }, "T", "<C-W>T")
-- switches two windows
map({ "n", "v" }, "X", "<C-W>x")

-- Terminal
map({ "n", "v" }, "<leader>tt", ":10split term://zsh<CR>i")
map("t", "<ESC>", "<C-\\><C-n>")
map("t", "jk",    "<C-\\><C-n>")
map("t", "<C-h>", "<C-\\><C-N><C-w>h")
map("t", "<C-j>", "<C-\\><C-N><C-w>j")
map("t", "<C-k>", "<C-\\><C-N><C-w>k")
map("t", "<C-l>", "<C-\\><C-N><C-w>l")

-- Sed
map("n", "<leader>ss", ":%s:::g<LEFT><LEFT><LEFT>")

-- Execute @m
map("n", "<C-m>", "@m")

-- Copy/Pasta
map("v", "<C-c>", "\"*y :let @+=@*<CR>")
map({ "n", "v" }, "<C-p>", "\"+p")

map("n", "<", "<<<ESC>")
map("n", ">", ">><ESC>")
map("n", "<leader>/", ":nohlsearch<CR>")

-- TODO rarely used, use longer name
map("v", "<leader>s", "c<++><ESC>:read!echo<SPACE>$((<C-r>\"))<CR>kJde:.s/<++>/<C-r>\"<CR>:noh<CR>")
map("n", "<leader>dt", ":%s:\\s\\+$::ge<CR>:nohlsearch<CR>")
map("n", "<leader>rt", ":retab<CR>")

-- Folding
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevelstart = 99
-- za - toggle fold
-- zA - toggle recursebly
-- zM - close all
-- zR - open all

-- super usefull
map("i", "jk", "<ESC>")

map("n", "<C-s>", ":w!<CR>") -- save
map("n", "<C-d>", ":x<CR>")  -- save and exit
map("n", "<C-t>", ":tabnew<CR>") -- new tab
vim.cmd("cnoremap sudow w !sudo tee % >/dev/null") -- sudo write
vim.cmd("cnoremap camel [a-z][A-Z]") -- highlight camel case


local modifiers = { 
  "A",  -- for linux (Alt)
  "D",  -- for macos (Command -> Alt is remapped to Command on my macos)
}

local function mod_map(shortcut, command)
  for _, key in ipairs(modifiers) do
    for _, mode in ipairs({ "n", "i" }) do
      if mode == "n" then
        map(mode, "<" .. key .. "-" .. shortcut .. ">", function()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(command, true, false, true), "n", false)
        end, { silent = true })
      else
        map(mode, "<" .. key .. "-" .. shortcut .. ">", function()
          vim.cmd.stopinsert()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(command, true, false, true), "n", false)
        end, { silent = true })
      end
    end
  end
end


mod_map(";", "A;<ESC>")
mod_map(":", "A:<ESC>")

-- mod_map("SPACE", "A<SPACE>") -- (command-space) is bound in macos 

-- mod_map("=",     "A=") -- (A-=) and (A--) are bound in alacritty, they increase/decerase font size

mod_map(".", "A.")
mod_map(",", "A,")

mod_map("{", "A{}<LEFT><CR><ESC>O") -- { is actually <S-[>

mod_map("i", "gT") -- prev
mod_map("o", "gt") -- next

for i = 1, 9 do
  mod_map(tostring(i), i .. "gt")
end

mod_map("0", ":tablast<CR>")

-- sane tab widths
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    vim.opt_local.smarttab = true
  end,
})
