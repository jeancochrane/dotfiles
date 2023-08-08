" execute pathogen#infect()
syntax on
" filetype plugin indent on

set colorcolumn=80
set wrap

set number                      " Show line numbers
set showcmd                     " Show me what I'm typing
set noswapfile                  " Don't use swapfile

" Apply the indentation of the current line to the next line.
set autoindent
set smartindent
set complete-=i
set showmatch
set smarttab

set tabstop=4
set shiftwidth=4
set expandtab

set nrformats-=octal
set shiftround

" Search should only be case-sensitive if it includes a capital letter
set smartcase

" Never worry about case when saving or quitting
command W w
command Wq wq
command Q q

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Just go out in insert mode
imap jk <ESC>l

" Highlight lines on insert
autocmd InsertEnter,InsertLeave * set cul!

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    let g:clipboard = {
        \   'name': 'WslClipboard',
        \   'copy': {
        \      '+': s:clip,
        \      '*': s:clip,
        \    },
        \   'paste': {
        \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        \   },
        \   'cache_enabled': 0,
        \ }
endif

" Remap leader to ','
let mapleader = ','

" ----------------------------------------- "
" File Type settings    	   	    "
" ----------------------------------------- "

au BufNewFile,BufRead *.vim setlocal noet ts=4 sw=4 sts=4
au BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
au BufNewFile,BufRead *.md setlocal spell expandtab ts=2 sw=2 tw=80
au BufNewFile,BufRead *.yml,*.yaml,*.json,*.lua setlocal expandtab ts=2 sw=2
au BufNewFile,Bufread *.sql setlocal expandtab ts=4 sw=4

" python indent
autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80 smarttab expandtab

" Spell check for git commits
autocmd FileType gitcommit setlocal spell

" Ignore these files
set wildignore+=.git,*.sw?,*.pyc

" --------------------- "
" Vim-specific plugins
" (ignored by neovim)
" --------------------- "

" Whitespace configuration
" let g:better_whitespace_enabled=1
" let g:strip_whitespace_on_save=1
" let g:better_whitespace_filetypes_blacklist=['diff']

" Highlight trailing whitespace
" highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" match ExtraWhitespace /\s\+$/

" Delete trailing whitespace in selected filetypes
" autocmd BufWritePre .vimrc,*.md :%s/\s\+$//e

" Change cursor shape on insert
" let &t_SI = "\e[6 q"
" let &t_EI = "\e[2 q"
"
" Color scheme
" set background=dark
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" colorscheme solarized
