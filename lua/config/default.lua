local o = vim.o
local g = vim.g
local opt = vim.opt
local map = vim.keymap.set
local env = vim.env

g.mapleader = ','

o.encoding = 'utf-8'
env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
o.termguicolors = true
vim.o.termguicolors = true
o.viminfo = ''

-- o.cmdheight = 0
o.mouse = "a" -- enable mouse in all modes
o.clipboard = "unnamedplus" -- use system clipboard
o.number = true
o.relativenumber = false
o.hidden = true

opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true

opt.updatetime = 200
opt.ttimeoutlen = 0

opt.redrawtime = 10000
opt.maxmempattern = 20000

opt.iskeyword:append("-") -- Treat dash as part of word
opt.backspace = "indent,eol,start"
opt.smoothscroll = true

o.showcmd = true
o.wrap = false
o.cursorline = true
o.autoindent = true
o.ignorecase = true
o.smartcase = true
o.showmatch = true
o.visualbell = true
o.sidescrolloff = 10
o.scrolloff = 10
opt.shortmess:append("c") -- supress completition menu messages
opt.virtualedit = "block"
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
o.splitkeep = "screen"


-- switch C-i C-o -> [C-i PREV, C-i NEXT]
map("n", "<C-i>", "<C-o>")
map("n", "<C-o>", "<C-i>")

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
-- Note: in a terminal <C-m> and <CR> are the same byte, so this also maps Enter.
map("n", "<C-m>", "@m")

-- Quickfix and location list windows.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(ev)
    -- Enter opens an entry. The <C-m> mapping above takes this key otherwise.
    vim.keymap.set("n", "<CR>", "<CR>", { buffer = ev.buf, remap = false, nowait = true })

    -- An outline from gO becomes a sidebar on the right. Neovim sets w:qf_toc
    -- only for outline lists, so an ordinary quickfix list stays at the bottom.
    if vim.w.qf_toc then
      vim.cmd("wincmd L")
      vim.cmd("vertical resize 40")
      vim.wo.winfixwidth = true
      vim.wo.number = false
      vim.wo.signcolumn = "no"
      vim.keymap.set("n", "gO", "<cmd>lclose<CR>",
        { buffer = ev.buf, silent = true, desc = "Close the outline sidebar" })
    end
  end,
})

-- gO toggles the outline sidebar instead of opening a second one.
local function toc_window()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local name = vim.w[win].qf_toc
    if name then
      return win, name
    end
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "help", "checkhealth", "man" },
  callback = function(ev)
    -- Keep the mapping the filetype plugin made, so each filetype opens its own outline.
    local open_toc = vim.fn.maparg("gO", "n", false, true)
    vim.keymap.set("n", "gO", function()
      local win, name = toc_window()
      if win then
        vim.api.nvim_win_close(win, true)
        -- A sidebar for this same buffer was open, so the key closed it.
        if name == vim.api.nvim_buf_get_name(0) then
          return
        end
      end
      if open_toc.callback then
        open_toc.callback()
      elseif open_toc.rhs and open_toc.rhs ~= "" then
        vim.cmd("normal " .. vim.api.nvim_replace_termcodes(open_toc.rhs, true, true, true))
      end
    end, { buffer = ev.buf, silent = true, desc = "Toggle the outline sidebar" })
  end,
})

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
mod_map("A-S-;", "A:<ESC>")

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

vim.filetype.add({
  extension = {
    env = "dotenv",
  },
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
  },
  pattern = {
    ["[jt]sconfig.*.json"] = "jsonc",
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
})

-- sane tab widths
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",

  callback = function()
    local space_count = 2

    if vim.bo.filetype == "python" then
      space_count = 4
    end

    vim.opt_local.tabstop = space_count
    vim.opt_local.shiftwidth = space_count
    vim.opt_local.expandtab = true
    vim.opt_local.smarttab = true
  end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    if vim.g.autodark_background then
      vim.o.background = vim.g.autodark_background
    end
    -- vim.notify("background changed to: " .. vim.o.background, vim.log.levels.WARN)
  end,
})

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded" -- Options: "single", "double", "rounded", "solid", "shadow"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Enter follows a markdown link: an anchor in this file, another file, or a URL.
-- With no link under the cursor it runs @m, same as <C-m> everywhere else.
local function md_slugify(heading)
  local s = heading:lower()
  s = s:gsub("`", ""):gsub("%*", ""):gsub("_", "")
  s = s:gsub("%[([^%]]*)%]%([^)]*%)", "%1")
  s = s:gsub("[^%w%s%-]", "")
  return (s:gsub("%s+", "-"))
end

local function md_jump_to_anchor(anchor)
  local want = anchor:lower()
  for i, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    local heading = line:match("^#+%s+(.*)$")
    if heading and md_slugify(heading) == want then
      vim.cmd("normal! m'")
      vim.api.nvim_win_set_cursor(0, { i, 0 })
      vim.cmd("normal! zz")
      return true
    end
  end
  return false
end

local function md_link_under_cursor()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  local init = 1
  while true do
    local first, last, target = line:find("%[[^%]]*%]%(%s*(%S-)%s*%)", init)
    if not first then
      return nil
    end
    if col >= first and col <= last then
      return target
    end
    init = last + 1
  end
end

local function md_follow_link()
  local target = md_link_under_cursor()
  if not target or target == "" then
    return vim.cmd("normal! @m")
  end
  if target:match("^%a[%w+.-]*://") or target:match("^mailto:") or target:match("^www%.") then
    return vim.ui.open(target)
  end
  local file, anchor = target:match("^([^#]*)#?(.*)$")
  if file ~= "" then
    local path = vim.fs.normalize(vim.fn.expand("%:p:h") .. "/" .. file)
    if vim.fn.filereadable(path) == 0 and vim.fn.filereadable(path .. ".md") == 1 then
      path = path .. ".md"
    end
    vim.cmd("edit " .. vim.fn.fnameescape(path))
  end
  if anchor ~= "" and not md_jump_to_anchor(anchor) then
    vim.notify("anchor not found: #" .. anchor, vim.log.levels.WARN)
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(ev)
    vim.keymap.set("n", "<CR>", md_follow_link,
      { buffer = ev.buf, silent = true, desc = "Follow the markdown link under the cursor" })
  end,
})
