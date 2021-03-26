colorscheme vividchalk
set hidden
set colorcolumn=120
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

" remap split switches
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" remap folding keys
nnoremap <F9> zA

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

" Json
au! BufRead,BufNewFile *.json set filetype=json
augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
  autocmd FileType json set foldmethod=syntax
augroup END

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
au BufNewFile main.go call PrepareGoMain()
function PrepareGoMain()
    r ~/.vim/templates/golang.go
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
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim/
set t_Co=256

" NERDtree
"open on every file
"autocmd vimenter * NERDTree
"open if no file specified
autocmd vimenter * if !argc() | NERDTree | endif
"close when last file is closed
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <C-n> :NERDTreeToggle<CR>

syn on
filetype on
filetype plugin on
filetype plugin indent on


""" Functions
" Shell ------------------------------------------------------------------- {{{

function! ExecuteInShell(command) " {{{
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>:AnsiEsc<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'
    echo 'Shell command ' . command . ' executed.'
endfunction " }}}
command! -complete=shellcmd -nargs=+ Shell call ExecuteInShell(<q-args>)
nnoremap <leader>! :Shell

" }}}
