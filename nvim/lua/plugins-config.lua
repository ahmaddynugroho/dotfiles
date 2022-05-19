-- gitsigns
require("gitsigns").setup({
    on_attach = Keybindings.gitsigns_oa
})

-- sort.nvim
require("sort").setup()

-- quick-scope
vim.cmd([[highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline]])
vim.cmd([[highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline]])

-- autopairs
require("nvim-autopairs").setup({})

-- kommentary
require("kommentary.config").use_extended_mappings()

-- toggleterm
local terminal_factory = require("toggleterm.terminal").Terminal
require("toggleterm").setup({
    open_mapping = Keybindings.toggleterm,
    direction = "float",
})
Terminal = {
    bash = terminal_factory:new({ start_in_insert = true }),
    lazygit = terminal_factory:new({
        dir = "git_dir",
        cmd = "lazygit",
        hidden = true,
    }),
    nvim = terminal_factory:new({
        dir = "~/dotfiles/nvim/",
        cmd = "nvim",
        hidden = true,
    }),
}

-- lualine
require("lualine").setup({ options = { theme = "tokyonight" } })

-- telescope
require("telescope")
require("telescope").load_extension("fzf")

-- cokeline
local get_hex = require("cokeline/utils").get_hex
require("cokeline").setup({
    default_hl = {
        fg = function(buffer)
            return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
        end,
        bg = "NONE",
    },
    components = {
        {
            text = function(buffer)
                return (buffer.index ~= 1) and "▏" or ""
            end,
            fg = get_hex("Normal", "fg"),
        },
        {
            text = function(buffer)
                return "    " .. buffer.devicon.icon
            end,
            fg = function(buffer)
                return buffer.devicon.color
            end,
        },
        {
            text = function(buffer)
                return buffer.filename .. "    "
            end,
            style = function(buffer)
                return buffer.is_focused and "bold" or nil
            end,
        },
        { text = "", delete_buffer_on_left_click = true },
        { text = "  " },
    },
})
