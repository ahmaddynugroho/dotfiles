local c = vim.cmd
local wk = require("which-key")
wk.setup({})
require("nvim-autopairs").setup({})

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

c([[
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ CheckBackspace() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    inoremap <silent><expr> <c-space> coc#refresh()

    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr :Telescope coc references<CR>

    nnoremap <silent> K :call ShowDocumentation()<CR>
    function! ShowDocumentation()
      if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
      else
        call feedkeys('K', 'in')
      endif
    endfunction
    autocmd CursorHold * silent call CocActionAsync('highlight')

    nmap <leader>lr <Plug>(coc-rename)
    nmap <leader>la  <Plug>(coc-codeaction)
    nmap <leader>lq  <Plug>(coc-fix-current)

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
