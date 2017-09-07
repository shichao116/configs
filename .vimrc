set nocompatible
filetype off
filetype plugin on

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set term=screen-256color
" switching tabs
map <C-m> :tabn<cr>
map <C-b> :tabp<cr>

" for tmux-vim-navigator
function! TmuxMove(direction)
	let wnr = winnr()
	silent! execute 'wincmd ' . a:direction
	" If the winnr is still the same after we
	" moved, it is the last pane
	if wnr == winnr()
		call system('tmux
		select-pane -' .
		tr(a:direction,
		'phjkl', 'lLDUR'))
	end
endfunction

nnoremap <silent> <c-h> :call TmuxMove('h')<cr>
nnoremap <silent> <c-j> :call TmuxMove('j')<cr>
nnoremap <silent> <c-k> :call TmuxMove('k')<cr>
nnoremap <silent> <c-l> :call TmuxMove('l')<cr>

" Press Space to turn off highlighting and clear any message already displayed.
" Search text highlight
set hlsearch
set incsearch
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/plugin/
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" vim-tmux-navigator
Plugin 'christoomey/vim-tmux-navigator'

" ctrl-p
Plugin 'ctrlpvim/ctrlp.vim' 
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" NERDTree with git and tab support
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
" Open with ctrl + n
map <C-n> :NERDTreeToggle %<CR> 
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" open NERDTree automatically when vim starts up on opening a directory?
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme='papercolor'

" easymotion
Plugin 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Jump to anywhere you want with minimal keystrokes, with just one key
" binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" fugitive.vim
Plugin 'tpope/vim-fugitive' 

" syntastic
"Plugin 'vim-syntastic/syntastic'
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" papercolor-theme
Plugin 'NLKNguyen/papercolor-theme'
set t_Co=256
set background=dark
set rtp+=/home/cshi/.vim/bundle/papercolor-theme/colors/PaperColor.vim 
colorscheme PaperColor
" turn on line numbers and status bar
set number
set laststatus=2

" tagbar
Plugin 'majutsushi/tagbar'
nnoremap <silent> <F9> :TagbarToggle<CR>

" auto complete
Plugin 'Valloric/YouCompleteMe'
"" in order to use default semantic autocomplete, <C-space> 
"" can not be the shortcut for switching system input
"let g:ycm_python_binary_path = '/usr/bin/python'

" for cscope
set csre

call vundle#end()
filetype plugin indent on


