" Leader
let mapleader = " "

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

"""""""""""""""""
" File Encoding "
"""""""""""""""""
set encoding=utf-8 " have some unicode

"""""""""""""
" Interface "
"""""""""""""
set number " show line numbers
set ruler " show line/column numbers
set cursorline " draw a line where the cursor is
set laststatus=2 " show a permanent status line (for Airline)
set backspace=indent,eol,start " make backspace act normally
" go up and down by screen line
nnoremap j gj
nnoremap k gk
set list listchars=tab:→\ ,trail:· " highlight tabs and trailing spaces
set list
set showcmd " display incomplete commands
set incsearch " do incremental searching
set autowrite " Automatically :write before running commands

nnoremap <Leader><Leader> <c-^> " Switch between the last two files

""""""""""""""""""""""""""""""""
" Syntax Highlighting & Colors "
""""""""""""""""""""""""""""""""
syntax on " enable syntax highlighting

let base16colorspace=256
colorscheme base16-materia

"""""""""""""
" Indenting "
"""""""""""""
set tabstop=2 " 2 spaces to a tab
set shiftwidth=2 " and again
set shiftround
set expandtab

"""""""""""""""""
" Line Wrapping "
""""""""""""""""
set textwidth=80 " lines should be wrapped at 80 chars
set formatoptions+=t " wrap at word boundaries
set colorcolumn=80 " show a marker on the 80 column line

""""""""
" Undo "
""""""""
set undofile " save undo files after closing
set undodir=$HOME/.vimundo " place to save undo files
set undolevels=1000 " how many undos
set undoreload=10000 " number of lines to save for undo

""""""""""""""
" Copy/Paste "
""""""""""""""
set pastetoggle=<F2> " use F2 to toggle paste
vnoremap <C-c> "*y

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Split Panes                                                             "
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow
set splitright

" ctrl-j to go down, not ctrl-w + j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <silent> vv <C-w>v " vv to generate new vertical split

"""""""""""""""""""""""""""""""""""""""""""""""""
" Search with The Silver Searcher               "
" https://github.com/ggreer/the_silver_searcher "
"""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag --literal --files-with-matches --nocolor --hidden --filename-pattern "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

""""""""""""""""""""
" Filetype Plugins "
""""""""""""""""""""
filetype plugin indent on " detect and use filetypes

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufNewFile,BufRead Brewfile set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd FileType text,markdown,mkd,pandoc call lexical#init()

  " ALE linting events
  if g:has_async
    set updatetime=1000
    let g:ale_lint_on_text_changed = 0
    autocmd CursorHold * call ale#Lint()
    autocmd CursorHoldI * call ale#Lint()
    autocmd InsertEnter * call ale#Lint()
    autocmd InsertLeave * call ale#Lint()
  else
    echoerr "This requires NeoVim or Vim 8"
  endif
augroup END

""""""""""""""""""""""""
" Plugin Configuration "
""""""""""""""""""""""""
let g:airline_powerline_fonts=1 " use powerline fonts
set noshowmode " don't show the mode selector twice
set ttimeoutlen=50 " speed up coming out of insert

let g:gitgutter_realtime=1 " update when typing stops
let g:gitgutter_eager=1 " update when tab/buffer changes

let g:pandoc#modules#disabled = ['folding', 'bibliographies']
let g:pandoc#formatting#mode = 'ha' " enable auto hard wrapping
let g:pandoc#formatting#smart_autoformat_on_cursormoved = 1
let g:pandoc#syntax#conceal#use = 0 " disable conceal

" enable airline with ALE
let g:airline#extensions#ale#enabled = 1

" enable SuperTab's context mode
let g:SuperTabDefaultCompletionType = 'context'

" vim-test mappings
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <Leader>gt :TestVisit<CR>

" map Run to leader-r
nnoremap <Leader>r :Run<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>
