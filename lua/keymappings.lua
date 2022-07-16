local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local function register_mappings(mappings, default_options)
	for mode, mode_mappings in pairs(mappings) do
		for _, mapping in pairs(mode_mappings) do
			local options = #mapping == 3 and table.remove(mapping) or default_options
			local prefix, cmd = unpack(mapping)
			pcall(vim.keymap.set, mode, prefix, cmd, options)
		end
	end
end

local function telescope_find_files()
	require("telescope.builtin").find_files({ hidden = true })
end

local border_options = { float = { border = "rounded" } }

-- NOTE<cmd> <leader> prefixed mappings are in whichkey-settings.lua

local mappings = {
	i = {
		-- Insert mode
		{ "kk", "<ESC>" },
		{ "jj", "<ESC>" },
		{ "jk", "<ESC>" },
		-- Terminal window navigation
		{ "<C-h>", "<C-\\><C-N><C-w>h" },
		{ "<C-j>", "<C-\\><C-N><C-w>j" },
		{ "<C-k>", "<C-\\><C-N><C-w>k" },
		{ "<C-l>", "<C-\\><C-N><C-w>l" },
		-- moving text
		{ "<C-j>", "<esc><cmd>m .+1<CR>==" },
		{ "<C-k>", "<esc><cmd>m .-2<CR>==" },
	},
	n = {
		-- Normal mode
		-- Better window movement
		{ "<C-h>", "<C-w>h", { silent = true } },
		{ "<C-j>", "<C-w>j", { silent = true } },
		{ "<C-k>", "<C-w>k", { silent = true } },
		{ "<C-l>", "<C-w>l", { silent = true } },
		-- Resize with arrows
		{ "<C-Up>", "<cmd>resize -2<CR>", { silent = true } },
		{ "<C-Down>", "<cmd>resize +2<CR>", { silent = true } },
		{ "<C-Left>", "<cmd>vertical resize -2<CR>", { silent = true } },
		{ "<C-Right>", "<cmd>vertical resize +2<CR>", { silent = true } },
		-- Ctrl + p fuzzy files
		{ "<C-p>", telescope_find_files },
		-- escape clears highlighting
		{ "<esc>", "<cmd>noh<cr><esc>" },
		-- yank to end of line on Y
		{ "Y", "y$" },
		-- lsp mappings
		{ "K", vim.lsp.buf.hover },
		{ "<C-k>", vim.lsp.buf.signature_help },
		{
			"[d",
			function()
				vim.diagnostic.goto_prev(border_options)
			end,
		},
		{
			"]d",
			function()
				vim.diagnostic.goto_next(border_options)
			end,
		},
		-- bufferline
		{ "H", "<cmd>BufferLineCyclePrev<CR>" },
		{ "L", "<cmd>BufferLineCycleNext<CR>" },
	},
	t = {
		-- Terminal mode
		-- Terminal window navigation
		{ "<C-h>", "<C-\\><C-N><C-w>h" },
		{ "<C-j>", "<C-\\><C-N><C-w>j" },
		{ "<C-k>", "<C-\\><C-N><C-w>k" },
		{ "<C-l>", "<C-\\><C-N><C-w>l" },
		-- map escape to normal mode in terminal
		{ "<Esc>", [[ <C-\><C-n> ]] },
		{ "jj", [[ <C-\><C-n> ]] },
	},
	v = {
		-- Visual/Select mode
		-- Better indenting
		{ "<", "<gv" },
		{ ">", ">gv" },
		-- hop words
		{ "f", require("hop").hint_words },
		-- moving text
		{ "J", "<cmd>m '>+1<CR>gv=gv" },
		{ "K", "<cmd>m '<-2<CR>gv=gv" },
	},
	x = {},
}

register_mappings(mappings, { silent = true, noremap = true })

-- S for search and replace in buffer
vim.cmd("nnoremap S :%s/")

-- hop in motion
local actions = { "d", "c", "<", ">", "y" }
for _, a in ipairs(actions) do
	vim.keymap.set("n", a .. "f", a .. "<cmd>lua require'hop'.hint_char1()<cr>")
end

-- Extra mappings
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
map("n", "<C-e>", "<C-w>") -- Close buffer
map("n", "<C-w>", ":bdelete<cr>") -- Close buffer

-- Hop
map("n", "f", "<cmd>HopWord<cr>")
map("n", "F", "<cmd>HopLine<cr>")
map({ "n", "i", "v" }, "<C-f>", "<esc><cmd>HopWordCurrentLine<cr>")

-- Global shorcuts
map({ "n", "i" }, "<F2>", ":Telescope keymaps <cr>")
map({ "n", "i" }, "<F3>", ":Telescope commands <cr>")
map({ "n", "i" }, "<F4>", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", opts)
map({ "n", "i" }, "<F10>", "<esc>:Telescope lsp_dynamic_workspace_symbols<cr>")
map({ "n", "i" }, "<F11>", "<esc>:Telescope lsp_document_symbols<cr>")
map({ "n", "i" }, "<F12>", "<esc><cmd>lua vim.lsp.buf.definition()<cr>")

-- File Picker
map({ "n", "i" }, "<C-]>", "<esc>:Telescope oldfiles hidden=true<cr>")

-- Comments
map("n", "<C-_>", "<Cmd>lua require('Comment.api').toggle_current_blockwise_op()<CR>") -- (CTRL + /) Add a comment
map("i", "<C-_>", "<Esc><Cmd>lua require('Comment.api').toggle_current_blockwise_op()<CR>^i") -- (CTRL + /) Add a comment
map("x", "<C-_>", '<ESC><CMD>lua require("Comment.api").toggle_blockwise_op(vim.fn.visualmode())<CR>')

-- LSP via Telescope
local telescope = require("telescope.builtin")
map("n", "gD", vim.lsp.buf.declaration)
map("n", "gd", telescope.lsp_definitions)
map("n", "gr", telescope.lsp_references)
map("n", "gi", telescope.lsp_implementations)
