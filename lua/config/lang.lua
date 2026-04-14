local function map_key(combo, letter)
  vim.keymap.set("i", "<leader>" .. combo, letter, { silent = true })
end

map_key("c'", "ć")
map_key("C'", "Ć")

map_key("ch", "č")
map_key("Ch", "Č")

map_key("dj", "đ")
map_key("Dj", "Đ")

map_key("zh", "ž")
map_key("Zh", "Ž")

map_key("sh", "š")
map_key("Sh", "Š")

map_key("ae", "ä")
map_key("Ae", "Ä")

map_key("oe", "ö")
map_key("Oe", "Ö")

map_key("ue", "ü")
map_key("Ue", "Ü")

map_key("ss", "ß")

map_key("a`", "à")
map_key("A`", "À")

map_key("i`", "ì")
map_key("I`", "Ì")

map_key("e`", "è")
map_key("E`", "È")

map_key("e'", "é")
map_key("E'", "É")

map_key("o`", "ò")
map_key("O`", "Ò")

vim.keymap.set('i', '<leader>ti', '<C-v><Tab>', { silent = true, desc = "Insert literal tab" })
