" This theme should be only used with 256 colors enabled (xterm-256color, t_Co=256) and iTerm2 theme base16-railscasts256

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:color_name="Zavaster Dark"

" VIM
hi Normal ctermfg=7, ctermbg=234
hi Visual ctermbg=235
hi ColorColumn ctermbg=236
hi CursorLine ctermbg=236, cterm=none
hi CursorLineNr ctermfg=15, ctermbg=235
hi LineNr ctermfg=8, ctermbg=235
" Autocompletion menu
hi Pmenu ctermfg=3, ctermbg=235
hi PmenuSel ctermfg=15, ctermbg=237
hi SignColumn ctermbg=235
" Splits
hi StatusLine ctermbg=239, ctermfg=15, cterm=none
hi StatusLineNC ctermbg=237, ctermfg=232, cterm=none
hi VertSplit ctermbg=15, ctermfg=237

" Ruby
hi rubyInclude ctermfg=5
hi rubySymbol ctermfg=4
hi rubyConstant ctermfg=1
hi rubyString ctermfg=2
hi rubyStringDelimiter ctermfg=2
hi rubyInteger ctermfg=30
hi rubyFloat ctermfg=30
hi rubyClass ctermfg=130
hi rubyModule ctermfg=130
hi rubyDefine ctermfg=130
hi rubyFunction ctermfg=3
hi rubyInstanceVariable ctermfg=210
hi rubyClassVariable ctermfg=210
hi rubyRegexp ctermfg=6
hi rubyRegexpdelimiter ctermfg=6
hi rubyComment ctermfg=244
hi rubyTodo ctermfg=15
hi rubyBlockParameter ctermfg=3

" vim-gitgutter
hi GitGutterAdd ctermfg=2, ctermbg=235
hi GitGutterChange ctermfg=3, ctermbg=235
hi GitGutterDelete ctermfg=1, ctermbg=235
hi GitGutterChangeDelete ctermfg=1, ctermbg=235
" vim-fugitive
hi DiffAdd ctermbg=22, ctermfg=15
hi DiffChange ctermbg=17, ctermfg=15
hi DiffDelete ctermbg=52, ctermfg=15
hi DiffText ctermbg=17, ctermfg=15

