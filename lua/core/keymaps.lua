vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

vim.keymap.set("n", "<c-h>", "<C-W>h")
vim.keymap.set("n", "<c-j>", "<C-W>j")
vim.keymap.set("n", "<c-k>", "<C-W>k")
vim.keymap.set("n", "<c-l>", "<C-W>l")
vim.keymap.set("i", "jj", "<Esc>")

vim.keymap.set("n", "sv", ":vsplit<CR><C-w>l")
vim.keymap.set("n", "ss", ":split<CR><C-w>j")
vim.keymap.set("n", "te", ":tabedit<CR>")
vim.keymap.set("n", "t]", ":tabnext<CR>")
vim.keymap.set("n", "t[", ":tabprev<CR>")
vim.keymap.set("n", "gr", ":lua vim.lsp.buf.references()<CR>")

vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")
