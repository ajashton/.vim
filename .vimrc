silent! call pathogen#infect()

syntax enable
filetype plugin indent on

set t_Co=256
set vb
set number
set nocompatible
set showmatch
set ruler
set nowrap
set hlsearch
set colorcolumn=80
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab
set scrolloff=3
set wildignore+=node_modules
set backupdir=/Users/tmcw/tmp/
set directory=/Users/tmcw/tmp/
set nobackup
set nowritebackup

set background=dark
colorscheme Tomorrow-Night
if has("gui_running")
  set go-=T
  set guifont=M+_1m_light:h13
  set noballooneval
else
  set mouse=a
endif

highlight clear SignColumn
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd BufNewFile,BufRead *.json set filetype=javascript
autocmd BufRead,BufNewFile *.mml set syntax=javascript
autocmd BufRead,BufNewFile *.bones set syntax=javascript
autocmd BufRead,BufNewFile *.result set syntax=xml
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufNewFile,BufRead *._ set filetype=html
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Show syntax highlighting groups for word under cursor
nmap <C-S-A> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! LightMode()
  colorscheme habiLight

  set guifont=Monaco:h13
endfunc

""" FocusMode
function! ToggleFocusMode()
  if (&foldcolumn != 12)
    set laststatus=0
    set numberwidth=10
    set foldcolumn=12
    set columns=80
    set noruler
    set nonumber
    hi FoldColumn ctermbg=none
    hi LineNr ctermfg=0 ctermbg=none
    hi NonText ctermfg=0
  else
    set number
    set laststatus=2
    set numberwidth=4
    set foldcolumn=0
    set ruler
    execute 'colorscheme ' . g:colors_name
  endif
endfunc
nnoremap <F1> :call ToggleFocusMode()<cr>

" Statusline helper
if has("eval")
function! SL(function)
  if exists('*'.a:function)
    return call(a:function,[])
  else
    return ''
  endif
endfunction
endif

set statusline=[%n]\ %<%.99f\ %h%w%m%r%y%{SL('fugitive#statusline')}%{SL('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\ %P

let NERDTreeDirArrows=1
let NERDTreeMinimalUI=1
let NERDTreeIgnore=['\.pyc$', 'CVS', '\~$']
let NERDTreeHijackNetrw=1

let g:syntastic_enable_signs=1
let g:syntastic_disabled_filetypes = ['cpp']
let g:syntastic_javascript_checkers = ['jshint']

let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1

let g:ctrlp_extensions = ['line']
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ackprg = 'ag --nogroup --nocolor --column'

let g:solarized_contrast="low"

inoremap <expr><TAB>  pumvisible() ? "<C-n>" : "<TAB>"
nnoremap <leader>d :NERDTreeToggle<cr>
nnoremap <leader>a :Ack 
map <leader>gu :GundoToggle<CR>
map <c-l> :CtrlPLine<CR>
map <c-k> :CtrlPBuffer<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

set shell=/bin/bash
