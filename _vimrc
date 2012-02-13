" enable pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set encoding=utf-8 " have some unicode

" interface
set number " show line numbers
set showcmd " show the current command
set ruler " show standard line/column numbers
set cursorline " indicate what line we're on

" indenting
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
set expandtab
set autoindent

" colours
syntax enable
set background=dark
colorscheme solarized

" status bar ([filename] [type] [position])
set laststatus=2
let g:Powerline_symbols = 'fancy'

" enable filetype plugins
filetype on
filetype plugin on

" system paste (disable autoindenting when pasting from the system)
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" plugins

" only enable CloseTag for HTML/XML like files
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim

" specific language support

" ruby
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 

" CSS
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" Markdown
autocmd BufNewFile,BufRead *.txt,*.markdown,*.md setlocal ft=markdown

" Nginx Conf
au BufRead,BufNewFile /etc/nginx/* set ft=nginx
