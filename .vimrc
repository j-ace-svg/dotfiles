" Make CtrlP use ag for listing the files. Way faster and no useless files.
let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'
let g:ctrlp_use_caching = 0

" Enable mouse support.
set mouse=n

set nobackup
set noswapfile
if has('persistent_undo')
    set undodir=~/.vim/undo-dir " directory for undo files
    set undofile    " keep an undo file (undo changes after closing)
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
    packadd! matchit
endif

" Autoindent
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

let g:PHP_default_indenting = 1

" Relative line numbers
set number
set relativenumber
highlight LineNr ctermfg=darkgrey

" Faster macros (no redraw until end of macro)
set lazyredraw

" Search options
set nohlsearch
set incsearch
noh
augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

" Kill blank buffer on close
function! s:CleanEmptyBuffers()
    let buffers = filter(range(1, bufnr('$')), 'empty(bufname(v:val)) && empty(win_findbuf(v:val)) && !getbufvar(v:val, "&mod")')
    if !empty(buffers)
        silent! exe 'bw ' . join(buffers, ' ')
    endif
endfunction

let g:netrw_fastbrowse = 0
let g:netrw_list_hide='^\./$,^\.\./$'
augroup vimrc-netrw-changes
    autocmd!
    autocmd FileType netrw setl bufhidden=wipe
    autocmd FileType netrw nnoremap <buffer> <Leader>j <Enter>
    autocmd BufHidden * call s:CleanEmptyBuffers()
augroup END

" Other options
set exrc
set guicursor=
set splitright
set nowrap
set scrolloff=8
set completeopt=menuone,noinsert,noselect
set signcolumn=yes
set sidescroll=0
set sidescrolloff=8
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Custom commands
let mapleader = " "
nnoremap <Leader><Space> <Space>

" Insert Mode
inoremap jk <Esc>l
inoremap kj <Esc>l
inoremap GG <Esc>bgUiwea

" Text input modes
lnoremap <C-j> <CR>

" Abbreviations
iab inrm inoremap
iab nnrm nnoremap
iab cmd command
iab <lt>L <lt>Leader

" Normal Mode
nnoremap J 5j
nnoremap K 5k
nnoremap g, ^
nnoremap g. $
nnoremap <Leader>J J<CR>

" Operator Pending Mode
onoremap , ^
onoremap . $

" Split mappings
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Leader>sh <C-w><
nnoremap <Leader>sk <C-w>+
nnoremap <Leader>sj <C-w>-
nnoremap <Leader>sl <C-w>>
nnoremap <Leader>sH <C-w>H
nnoremap <Leader>sJ <C-w>J
nnoremap <Leader>sK <C-w>K
nnoremap <Leader>sL <C-w>L

" Tab mappings
nnoremap <silent> <Leader>tt :tabnew<CR>
nnoremap <silent> <Leader>tw :tabclose<CR>
nnoremap <silent> <Leader>tn :tabnext<CR>
nnoremap <silent> <Leader>tp :tabprev<CR>
nnoremap <silent> <Leader>to :tabo<CR>

" Generic Leader mappings
nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>q :q<CR>
nnoremap <silent> <Leader>Q :q!<CR>
nnoremap <silent> <Leader>z :bd<CR>
nnoremap <silent> <Leader>Z :bd!<CR>
nnoremap <silent> <Leader>o :x<CR>
nnoremap <silent> <Leader>e :Ex<CR>
nnoremap <silent> <Leader>E :Vex!<CR>
nnoremap <silent> <Leader>/ :noh<CR>

" Git Leader mappings
nnoremap <silent> <Leader>gs :Git status<CR>
nnoremap <silent> <Leader>gl :Git log<CR>
nnoremap <silent> <Leader>gd :Git diff<CR>
nnoremap <silent> <Leader>g<Leader> :Git<CR>
nnoremap <Leader>gc :Git commit
nnoremap <Leader>gp :Git push -u
nnoremap <Leader>gr :Git pull
nnoremap <Leader>ga :Git add
nnoremap <Leader>gb :Git branch
nnoremap <Leader>go :Git checkout

" Terminal
nnoremap <Leader>te :!
nnoremap <silent> <Leader>tt :terminal<CR>

" Telescope
nnoremap <Leader>ps :lua require('telescope.builtin').live_grep({ search = ""})<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files({ search = ""})<CR>

" Command Mode
" Commands
command! O wincmd o
command! Reload source ~/.config/nvim/init.vim

" Split abbreviations
cabb v vert
cabb b bel
cabb sp split

" Git abbreviations
cabb g Git
cabb gd Git diff
cabb gls Git ls-files
cabb gsh Git stash

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'github/copilot.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'gruvbox-community/gruvbox'
Plug 'mbbill/undotree'
Plug 'ThePrimeagen/vim-be-good'

" File switching
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ThePrimeagen/harpoon'
call plug#end()

" Color scheme
colorscheme gruvbox

" Harpoon
nnoremap <silent> <Leader>fa :lua require('harpoon.mark').add_file()<CR>
nnoremap <silent> <Leader>fm :lua require('harpoon.ui').toggle_quick_menu()<CR>
nnoremap <silent> <Leader>fh :lua require('harpoon.ui').nav_file(1)<CR>
nnoremap <silent> <Leader>fj :lua require('harpoon.ui').nav_file(2)<CR>
nnoremap <silent> <Leader>fk :lua require('harpoon.ui').nav_file(3)<CR>
nnoremap <silent> <Leader>fl :lua require('harpoon.ui').nav_file(4)<CR>
