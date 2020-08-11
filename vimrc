" Set compatibility to Vim only
set nocompatible

autocmd vimenter * colorscheme gruvbox

" Helps force plug-ins to load correctly when it is turned back on below.
filetype off

" Turn on syntax highlighting.
syntax on

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" For plug-ins to load correctly.
filetype plugin indent on

set autoindent
set smartindent
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set expandtab     " Convert tab to space all cases
set tabstop=2
set shiftwidth=2
set bg=dark       " Background style to dark

" Numbers
set cursorline
set relativenumber
set number
set numberwidth=4

hi CursorLineNR guifg=yellow

" NERD tree configuration
noremap <C-d> :NERDTreeToggle<CR>
nnoremap F :NERDTreeFind<CR>
let NERDTreeShowHidden=1

" fzf
set rtp+=/usr/bin/fzf

noremap ` :Files<CR>
noremap ; :Buffers<CR>

" file indentation
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
