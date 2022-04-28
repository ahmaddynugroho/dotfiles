local map = require 'utils'.map

vim.g.mapleader = [[ ]]
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})

map('', '<f1>', '<cmd>FloatermToggle<cr>') -- Disable annoying F1 binding
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map('n', '<leader>q', '<cmd>qa<cr>', { silent = true })
map('n', '<leader>x', '<cmd>x!<cr>', { silent = true })
map('n', '<leader>w', '<cmd>w<cr>', { silent = true })
map('i', 'jk', '<ESC>', {noremap = true})
map('i', 'kj', '<ESC>', {noremap = true})
map('n', '<M-j>', ':resize -2<CR>', {noremap = true, silent = true})
map('n', '<M-k>', ':resize +2<CR>', {noremap = true, silent = true})
map('n', '<M-h>', ':vertical resize -2<CR>', {noremap = true, silent = true})
map('n', '<M-l>', ':vertical resize +2<CR>', {noremap = true, silent = true})
map('n', '<Tab>', ':bnext<CR>', {noremap = true, silent = true})
map('n', '<S-Tab>', ':bprevious<CR>', {noremap = true, silent = true})
map('v', '<', '<gv', {noremap = true, silent = false})
map('v', '>', '>gv', {noremap = true, silent = false})

map('n', '\\', ':Neotree reveal<CR>', { silent = true })

map('n', '<leader>ff', "<CMD>lua require('telescope.builtin').find_files()<CR>", { noremap = true })
map('n', '<leader>fg', "<CMD>lua require('telescope.builtin').live_grep()<CR>", { noremap = true })
map('n', '<leader>fb', "<CMD>lua require('telescope.builtin').buffers()<CR>", { noremap = true })
map('n', '<leader>fh', "<CMD>lua require('telescope.builtin').help_tags()<CR>", { noremap = true })
