local map = require'utils'.map
local wk = require 'which-key'

vim.g.mapleader = [[ ]]
vim.api
    .nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
map('', '<f1>', '<cmd>FloatermToggle<cr>') -- Disable annoying F1 binding
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true})
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true})
map('i', 'jk', '<ESC>', {noremap = true})
map('i', 'kj', '<ESC>', {noremap = true})
map('v', '<', '<gv', {noremap = true, silent = false})
map('v', '>', '>gv', {noremap = true, silent = false})

local toggleterm = [[<C-\>]]
wk.register({
    ['<leader>g'] = {
        function() Terminal.lazygit:toggle(20, 'float') end, 'Lazygit'
    },
    ['<leader>n'] = {
        function() Terminal.nvim:toggle(20, 'float') end, 'Edit neovim config'
    }
}, {noremap = true, silent = true})

wk.register({
    ['<leader>q'] = {'<cmd>qa<cr>', 'Close all'},
    ['<leader>x'] = {'<cmd>bd<cr>', 'Close this buffer'},
    ['<leader>w'] = {'<cmd>w<cr>', 'Save'},
    ['<M-j>'] = {':resize -2<CR>', 'Resize horizontal -2'},
    ['<M-k>'] = {':resize +2<CR>', 'Resize horizontal +2'},
    ['<M-h>'] = {':vertical resize -2<CR>', 'Resize vertical -2'},
    ['<M-l>'] = {':vertical resize +2<CR>', 'Resize vertical +2'},
    ['<Tab>'] = {':bnext<CR>', 'Next buffer'},
    ['<S-Tab>'] = {':bprevious<CR>', 'Previous buffer'},
    ['\\'] = {':Neotree reveal<CR>', 'Neotree'},
    ['<leader>f'] = {
        name = '+find',
        f = {"<CMD>lua require('telescope.builtin').find_files()<CR>", 'File'},
        o = {
            "<CMD>lua require('telescope.builtin').oldfiles()<CR>",
            'Old file (recent)'
        },
        g = {
            "<CMD>lua require('telescope.builtin').live_grep()<CR>", 'Live grep'
        },
        b = {"<CMD>lua require('telescope.builtin').buffers()<CR>", 'Buffer'},
        h = {"<CMD>lua require('telescope.builtin').help_tags()<CR>", 'Tags'}
    }
}, {silent = true})

wk.register({
    ['<leader>d'] = {
        name = '+diagnostic',
        e = {'<cmd>lua vim.diagnostic.open_float()<CR>', 'Open float'},
        ['['] = {'<cmd>lua vim.diagnostic.goto_prev()<CR>', 'Previous'},
        [']'] = {'<cmd>lua vim.diagnostic.goto_prev()<CR>', 'Next'},
        q = {'<cmd>lua vim.diagnostic.setloclist()<CR>', 'setloclist'}
    }
}, {silent = true})
local lspconfig_oa = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    wk.register({
        ['<leader>l'] = {
            name = '+lsp',
            D = {'<cmd>lua vim.lsp.buf.declaration()<CR>', 'Declaration'},
            d = {'<cmd>lua vim.lsp.buf.definition()<CR>', 'Definition'},
            t = {
                '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type definition'
            },
            K = {'<cmd>lua vim.lsp.buf.hover()<CR>', 'Hover'},
            i = {'<cmd>lua vim.lsp.buf.implementation()<CR>', 'Implementation'},
            k = {'<cmd>lua vim.lsp.buf.signature_help()<CR>', 'Signature help'},
            w = {
                name = '+workspace',
                a = {'<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', 'Add'},
                r = {
                    '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
                    'Remove'
                },
                l = {
                    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                    'List'
                }
            },
            r = {'<cmd>lua vim.lsp.buf.rename()<CR>', 'Rename'},
            c = {'<cmd>lua vim.lsp.buf.code_action()<CR>', 'Code action'},
            e = {'<cmd>lua vim.lsp.buf.references()<CR>', 'References'},
            f = {'<cmd>Neoformat<CR>', 'Neoformat'}
        }
    }, {silet = true})
end

Keybindings = {lspconfig_oa = lspconfig_oa, toggleterm = toggleterm}
