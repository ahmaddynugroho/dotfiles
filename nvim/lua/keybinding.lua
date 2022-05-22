local c = vim.cmd
local wk = require("which-key")
wk.setup({})
require("nvim-autopairs").setup({})

vim.g.mapleader = ","

c[[nnoremap <leader>q :q<CR>]]
c[[nnoremap <leader>w :w<CR>]]
c[[nnoremap <leader>x :bd<CR>]]

c[[inoremap jk <ESC>]]
c[[inoremap kj <ESC>]]

c([[
    nnoremap <leader>fd <cmd>Telescope fd<cr>
    nnoremap <leader>g <cmd>Telescope live_grep<cr>
    nnoremap <leader>b <cmd>Telescope buffers<cr>
    nnoremap <leader>o <cmd>Telescope oldfiles<cr>
]])

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

		-- Actions
		map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
		map("n", "<leader>hS", gs.stage_buffer)
		map("n", "<leader>hu", gs.undo_stage_hunk)
		map("n", "<leader>hR", gs.reset_buffer)
		map("n", "<leader>hp", gs.preview_hunk)
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end)
		map("n", "<leader>tb", gs.toggle_current_line_blame)
		map("n", "<leader>hd", gs.diffthis)
		map("n", "<leader>hD", function()
			gs.diffthis("~")
		end)
		map("n", "<leader>td", gs.toggle_deleted)

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})

c([[nnoremap \ :NeoTreeRevealToggle<CR>]])

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

    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    nmap <leader>rn <Plug>(coc-rename)
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    nmap <leader>ac  <Plug>(coc-codeaction)

    nmap <leader>cl  <Plug>(coc-codelens-action)

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

    nmap <space>q  <Plug>(coc-fix-current)
    nnoremap <silent><nowait> <space>a  :Telescope coc diagnostics<CR>
    nnoremap <silent><nowait> <space>A  :Telescope coc workspace_diagnostics<CR>
    nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
    nnoremap <silent><nowait> <space>c  :Telescope coc commands<CR>
    nnoremap <silent><nowait> <space>o  :Telescope coc document_symbols<CR>
    nnoremap <silent><nowait> <space>s  :Telescope coc workspace_symbols<CR>
    nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
    nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
    nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
]])
