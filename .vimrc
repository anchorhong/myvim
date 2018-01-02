set nocompatible 
filetype off


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'tpope/vim-fugitive'
Plugin 'groenewege/vim-less'
Plugin 'godlygeek/tabular'
Plugin 'davidhalter/jedi-vim'
Plugin 'tomasr/molokai'
Plugin 'tmhedberg/SimpylFold'
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/indentpython.vim'
call vundle#end() " Must
filetype plugin indent on "Must



" Color scheme 
" Switch syntax hightlighting on, when the terminal has colors

syntax enable

autocmd BufRead,BufNewFile Appraisals set filetype=ruby
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.py set filetype=python
colorscheme solarized8
set background=dark
"colorscheme molokai 
"highlight NonText guibg=#060606
"highlight Folded guibg =#0A0A0A guifg=#9090D0

set backspace=2
set ruler
set showcmd
set fileencoding=utf-8
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif
filetype plugin indent on

let python_highlight_all=1
syntax on
" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Enable folding
set foldmethod=indent
set foldlevel=99

"Python PEP8 Style
au BufNewFile,BufRead *.py
\ set tabstop=4 |
\ set softtabstop=4 |
\ set shiftwidth=4 |
\ set expandtab |
\ set autoindent |
\ set fileformat=unix |

au BufNewFile,BufRead *.js,*.html,*.css
\ set tabstop=2 |
\ set softtabstop=2 |
\ set shiftwidth=2 |

set textwidth=80
set colorcolumn=+1
set number
set numberwidth=5
set hlsearch
" Highlight current line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

set splitbelow
set splitright
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" 退出vim后内容还在终端显示
set t_ti= t_te=
" 关掉上下左右键，强迫自己用hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

let mapleader = "-"  "Set <leader> is '-'
nnoremap <leader><space> viw " Select Word

" YCM
map <leader>gg  :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>

" Enable folding with the spacebar
nnoremap <leader>z za
let g:SimpylFold_docstring_preview=1

" NerdTree Setting
let NERDChristmasTree=0
let NERDTreeWinSize=35
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="left"
autocmd vimenter * if !argc() | NERDTree | endif  " Automatically open a NERDTree if no files where specified
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " Close vim if the only window left open is a NERDTree
nmap <F5> :NERDTreeToggle<cr> 


" Tagbar
let g:tagbar_width=35
let g:tagbar_autofocus=1
nmap <F6> :TagbarToggle<CR>


" ctrap
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.png,*.jpg,*.jpeg,*.gif " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " Ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
set laststatus=2 " Always display the status line
set statusline+=%{fugitive#statusline()} "  Git Hotness

" Set for jedi-vim
let g:jedi#goto_command = "<leader>gt"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>gd"
let g:jedi#documentation_command = "D"
let g:jedi#usages_command = "<leader>u"
let g:jedi#completions_command = "<leader><Tab>"
let g:jedi#rename_command = "<leader>r"


" flake 8 
let python_highlight_all=1
syntax on

""""""""""""""""""""""
    "Quickly Run
""""""""""""""""""""""
map <F10> :call CompileRunGcc()<CR>
func! CompileRunGcc()
   exec "w"
   if &filetype == 'c'
               exec "!g++ % -o %<"
               exec "!time ./%<"
   elseif &filetype == 'cpp'
               exec "!g++ % -o %<"
               exec "!time ./%<"
   elseif &filetype == 'java'
               exec "!javac %"
               exec "!time java %<"
   elseif &filetype == 'sh'
               exec ":!time bash %"
   elseif &filetype == 'python'
                exec "!time python3 %"
   elseif &filetype == 'html'
               exec "!firefox % &"
   elseif &filetype == 'go'
         "      exec "!go build %<"
               exec "!time go run %"
   elseif &filetype == 'mkd'
               exec "!~/.vim/markdown.pl % > %.html &"
               exec "!firefox %.html &"
   endif
endfunc
