if exists('loaded_trailing_tab_plugin') | finish | endif
let loaded_trailing_tab_plugin = 1

if !exists('g:extra_tab_ignored_filetypes')
    let g:extra_tab_ignored_filetypes = []
endif

function! ShouldMatchTab()
    for ft in g:extra_tab_ignored_filetypes
        if ft ==# &filetype | return 0 | endif
    endfor
    return 1
endfunction

" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight UnwantedTab ctermbg=darkred guibg=#382424
autocmd ColorScheme * highlight UnwantedTab ctermbg=red guibg=red
autocmd BufWinEnter * if ShouldMatchTab() | match UnwantedTab /^\t\+/ | endif

" The above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * if ShouldMatchTab() | match UnwantedTab /^\t\+/ | endif
autocmd InsertEnter * if ShouldMatchTab() | match UnwantedTab /^\t\+\%#\@<!/ | endif
