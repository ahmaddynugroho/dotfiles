MUtils = {}
local c = vim.cmd
local wk = require("which-key")
wk.setup({})
local npairs = require("nvim-autopairs")
npairs.setup({ map_cr = false })

vim.g.mapleader = " "

c([[inoremap jk <ESC>]])
c([[inoremap kj <ESC>]])

c([[nnoremap \ :NeoTreeRevealToggle<CR>]])

c([[nmap s <cmd>Pounce<CR>
nmap S <cmd>PounceRepeat<CR>
vmap s <cmd>Pounce<CR>
omap gs <cmd>Pounce<CR>]])

wk.register({
	["<leader>"] = {
		q = { ":q<CR>", "Quit" },
		w = { ":w<CR>", "Save" },
		x = { ":bd<CR>", "Close buffer" },

		f = { ":Telescope fd<CR>", "Files" },
		g = { ":Telescope live_grep<CR>", "Grep live" },
		r = { ":Telescope grep_string<CR>", "Grep string" },
		b = { ":Telescope buffers<CR>", "Buffers" },
		o = { ":Telescope oldfiles<CR>", "Recent files" },
	},
})

wk.register({
	["<leader>l"] = {
		name = "+lsp (coc)",
		d = { ":Telescope coc diagnostics<CR>", "Diagnostics" },
		D = { ":Telescope coc workspace_diagnostics<CR>", "Workspace diagnostics" },
		e = { ":<C-u>CocList extensions<cr>", "Extensions" },
		c = { ":Telescope coc commands<CR>", "Commands" },
		s = { ":Telescope coc document_symbols<CR>", "Document symbols" },
		S = { ":Telescope coc workspace_symbols<CR>", "Workspace symbols" },
		j = { ":<C-u>CocNext<CR>", "Next" },
		k = { ":<C-u>CocPrev<CR>", "Prev" },
		p = { ":Telescope resume<CR>", "Resume last list" },
		r = { "<Plug>(coc-rename)", "Rename", noremap = false },
		a = { "<Plug>(coc-codeaction)", "Code action", noremap = false },
		q = { "<Plug>(coc-fix-current)", "Fix current", noremap = false },
	},
	g = {
		d = { "<Plug>(coc-definition)", "Go to definition", noremap = false },
		y = { "<Plug>(coc-type-definition)", "Go to type definition", noremap = false },
		i = { "<Plug>(coc-implementation)", "Go to implementation", noremap = false },
		r = { ":Telescope coc references<CR>", "List references", noremap = false },
	},
})

require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		wk.register({
			["<leader>h"] = {
				name = "+hunk operation",
				S = { gs.stage_buffer, "Stage buffer" },
				u = { gs.undo_stage_hunk, "Undo stage hunk" },
				R = { gs.reset_buffer, "Reset buffer" },
				p = { gs.preview_hunk, "Preview hunk" },
				b = {
					function()
						gs.blame_line({ full = true })
					end,
					"Blame line",
				},
				d = { gs.diffthis, "Diff this" },
				D = {
					function()
						gs.diffthis("~")
					end,
					"Diff buffer",
				},
			},
			["<leader>t"] = {
				name = "+hunk toggle",
				b = { gs.toggle_current_line_blame, "Toggle line blame" },
				d = { gs.toggle_deleted, "Toggle deleted" },
			},
		})

		map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})

vim.keymap.set("i", "<TAB>", function()
	if vim.fn.pumvisible() then
		return "<C-n>"
	elseif vim.fn.CheckBackspace() then
		return "<TAB>"
	else
		vim.fn["coc#refresh"]()
	end
end, { expr = true, noremap = true, silent = true })

vim.keymap.set("i", "<S-TAB>", function()
	return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-h>"
end, { expr = true, noremap = true, silent = true })

_G.MUtils.completion_confirm = function()
	if vim.fn.pumvisible() ~= 0 then
		return vim.fn["coc#_select_confirm"]()
	else
		return npairs.autopairs_cr()
	end
end

vim.api.nvim_set_keymap("i", "<CR>", "v:lua.MUtils.completion_confirm()", { expr = true, noremap = true })

c([[

    function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    inoremap <silent><expr> <c-space> coc#refresh()


    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)


    nnoremap <silent> K :call ShowDocumentation()<CR>
    function! ShowDocumentation()
      if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
      else
        call feedkeys('K', 'in')
      endif
    endfunction
    autocmd CursorHold * silent call CocActionAsync('highlight')


    augroup mygroup
      autocmd!
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    if has('nvim-0.4.0') || has('patch-8.2.0750')
      nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
      inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
      inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
      vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    command! -nargs=0 Format :call CocActionAsync('format')
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)
    command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
]])
