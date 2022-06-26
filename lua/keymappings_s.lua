local map = vim.keymap.set
local opts = { noremap = true, silent = true }
-- -- Copy / Paste / Cut

map("v", "<C-c>", "y") -- Copy: As mostly in visual mode.
map("i", "<C-v>", "<c-r>+") -- Copy: As in visual mode.
map("v", "<C-x>", "d") -- Copy: As in visual mode.
map("i", "<C-x>", "<c-o>dd") -- In insert mode cut whole line.
map("n", "<C-v>", "a<c-r>+<esc>") -- Enter insert mode, get register, paste it, back to normal mode.

--
map("i", "<C-ins>", "<Esc>") -- exit insert mode.
map("n", "<ins>", "a") -- Enter insert mode (appending)

map("n", "<C-a>", "ggVGygv") -- Select and yank entire buffer
map("i", "<C-a>", "<esc>ggVGygv") -- Select and yank entire buffer

-- -- Undo/Redo
map("i", "<C-z>", "<C-o>u") -- Undo
map("n", "<C-z>", "u") -- undo
map("v", "<C-z>", "u") -- undo
map("n", "<C-y>", ":redo<cr>") -- Redo

-- "fine grained" undo.
-- https://stackoverflow.com/questions/2895551/how-do-i-get-fine-grained-undo-in-vim
map("i", "<Space>", "<Space><C-g>u")
map("i", "<Return>", "<Return><C-g>u")
map("i", "<Tab>", "<Tab><C-g>u")

-- -- Navigate through buffers
map("n", "<S-Tab>", ":BufferLineCyclePrev<cr>")
map("n", "<Tab>", ":BufferLineCycleNext <cr>")
map("n", "<C-s>", ":w<cr>") -- Save buffer
map("i", "<C-s>", "<Esc>:w<cr>") -- Save buffer
map("n", "<C-w>", ":bdelete<cr>") -- Close buffer

-- Hop
map("n", "<C-f>", ":HopPattern<cr>")
map("i", "<C-f>", "<Esc>:HopPattern<cr>")
map(
	"n",
	"f",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
	{}
)
map(
	"n",
	"F",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
	{}
)
map(
	"o",
	"f",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
	{}
)
map(
	"o",
	"F",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
	{}
)
map(
	"",
	"t",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
	{}
)
map(
	"",
	"T",
	"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
	{}
)
-- -- Code Comment
-- --map("i", "<C-_>","/*  */<Esc>hhi") -- (CTRL + /) Add a comment placeholder for javascript.
-- map("v", "<C-_>","<Esc><Cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>") -- (CTRL + /) Add a comment placeholder for javascript.
-- map("i", "<C-_>","<Esc><Cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>^i") -- (CTRL + /) Add a comment placeholder for javascript.
-- map("n", "<C-_>","<Esc><Cmd>lua require('Comment.api').toggle_current_linewise()<CR>^") -- (CTRL + /) Add a comment placeholder for javascript.
--
--
map("n", "<F12>", "<cmd>lua vim.lsp.buf.definition()<cr>")
--map("i", "<F12>","<cmd>lua vim.lsp.buf.definition()<cr>")
-- Help

map("n", "<F2>", ":Telescope keymaps <cr>")
map("n", "<F3>", ":Telescope commands <cr>")
map({ "n", "i" }, "<F4>", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", opts)
map({ "n", "i" }, "<C-]>", "<esc>:Telescope old_files hidden=true<cr>")
-- map({ "n", "i" }, "<C-[>", "<esc>:Telescope old_files hidden=true<cr>")

-- map("n", "<C-t>", ":ToggleTerm <cr>")
