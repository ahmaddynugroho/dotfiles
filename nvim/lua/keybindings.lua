local map = require'utils'.map

vim.g.mapleader = [[ ]]
vim.api
    .nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})

map('', '<f1>', '<cmd>FloatermToggle<cr>') -- Disable annoying F1 binding
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true})
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true})
map('n', '<leader>q', '<cmd>qa<cr>', {silent = true})
map('n', '<leader>x', '<cmd>x!<cr>', {silent = true})
map('n', '<leader>w', '<cmd>w<cr>', {silent = true})
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

map('n', '\\', ':Neotree reveal<CR>', {silent = true})

map('n', '<leader>ff', "<CMD>lua require('telescope.builtin').find_files()<CR>",
    {noremap = true})
map('n', '<leader>fg', "<CMD>lua require('telescope.builtin').live_grep()<CR>",
    {noremap = true})
map('n', '<leader>fb', "<CMD>lua require('telescope.builtin').buffers()<CR>",
    {noremap = true})
map('n', '<leader>fh', "<CMD>lua require('telescope.builtin').help_tags()<CR>",
    {noremap = true})

local opts = {noremap = true, silent = true}
local nsk = vim.api.nvim_set_keymap
local nbsk = vim.api.nvim_buf_set_keymap
nsk('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
nsk('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
nsk('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
nsk('n', '<leader><space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
Lspconfig_on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    nbsk(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    nbsk(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    nbsk(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    nbsk(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    nbsk(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    nbsk(bufnr, 'n', '<space>wa',
         '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    nbsk(bufnr, 'n', '<space>wr',
         '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    nbsk(bufnr, 'n', '<space>wl',
         '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
         opts)
    nbsk(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>',
         opts)
    nbsk(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    nbsk(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    nbsk(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    nbsk(bufnr, 'n', '<space>f', '<cmd>Neoformat<CR>', opts)
end
