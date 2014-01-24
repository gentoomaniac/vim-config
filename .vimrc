set colorcolumn=80
set expandtab
set hlsearch
set incsearch
set list
set listchars=tab:>-,eol:$
set nobackup
set noswapfile
set number
set shiftwidth=4
set tabstop=4
" set tw=79
"set nosmartindent
"set noautoindent
set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class
set title
set pastetoggle=<F2>

let mapleader = ","

" set keymappings for quit and safe
noremap <Leader>Q :quit!<CR>
noremap <Leader>q :quit<CR>
noremap <Leader>z :update<CR>

" set keymappings for tabs
inoremap <Leader>m :tabnext<CR>
noremap <Leader>n :tabprevious<CR>
noremap <Leader>t :tabnew<CR>

" keymappings for sorting
vnoremap <Leader>s :sort<CR>

" keep selection on intend blocks
vnoremap < <gv
vnoremap > >gv

" smooth jumps on line breaks
nnoremap j gj
nnoremap k gk

" set highlighting options
highlight ExtraWhitespace ctermbg=red guibg=red
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
highlight ColorColumn ctermbg=blue

" Puppet
au BufRead,BufNewFile *.pp set filetype=puppet
au! Syntax puppet source $VIM/syntax/puppet.vim
autocmd FileType puppet setlocal shiftwidth=2 tabstop=2

" automaticallyi trim trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e
" automatically give executable permissions if file begins with #! and contains '/bin/' in the path
au BufWritePost * call SetPlusX()
function SetPlusX()
    if getline(1) =~ "^#!"
        if getline(1) =~ "/bin/"
            silent !chmod a+x <afile>
        endif
    endif
endfunction

" TEMPLATES
" Python
au BufNewFile *.py call PreparePython()
function PreparePython()
    r ~/.vim/templates/python.py
    1d
endfunction


" PLUGINS
"filetype off
" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
call pathogen#infect()

" powerline
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set laststatus=2
set noshowmode
set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim
set t_Co=256

syn on
filetype on
filetype plugin on
filetype plugin indent on
