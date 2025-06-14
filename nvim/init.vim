
"--------------------------Plugins used -------------------------------
"
call plug#begin('~/.config/nvim/plugged')

Plug 'sainnhe/gruvbox-material'
Plug 'lifepillar/vim-gruvbox8'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', { 'branch': 'master' }  " Auto Completion
Plug 'lervag/vimtex'
Plug 'godlygeek/tabular' 
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'junegunn/fzf.vim'
"Plug 'https://github.com/github/copilot.vim.git'
"Plug 'ixru/nvim-markdown'
Plug 'preservim/vim-markdown'
"Plug 'tpope/vim-markdown'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-fugitive'
Plug 'srcery-colors/srcery-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
"Plug 'vim-pandoc/vim-pandoc'
"vimcolorschemes.com
"Plug 'morhetz/gruvbox'
"Plug 'NLKNguyen/papercolor-theme'
Plug 'tomasr/molokai'
"Plug 'ayu-theme/ayu-vim'
Plug 'sainnhe/sonokai'
Plug 'loctvl842/monokai-pro.nvim'

call plug#end()

"---------------------------General Settings ------------------------
"
set relativenumber
set number
set termguicolors
set smartindent
set noerrorbells
set incsearch
set autochdir
set signcolumn=no
"set tab to tow spaces for cpp 
set tabstop=2
set shiftwidth=2
set autoindent
set expandtab
set smarttab
set softtabstop=2
set cursorline
set conceallevel=2
set path+=**
set wildmenu
syntax enable
colorscheme gruvbox-material


" coc configuration

let g:coc_global_extensions = [
  \ 'coc-pairs', 
  \ 'coc-pyright',
  \ 'coc-texlab',
  \ ]

" Spell check
"  \ 'coc-ltex',
"
"let g:coc_filetype_map = {'tex': 'latex'}

" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Mardown COnfiguration

let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 2
let g:mkdp_refresh_slow = 1
let g:mkdp_browser = 'firefox'
let g:mkdp_theme = 'dark'
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 1,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }
" Tabularize configuration
" Auto align for markdown tables

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

"latex configuration

"    \    '-shell-escape',
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \    '-verbose',
    \    '-shell-escape',
    \    '-file-line-error',
    \    '-synctex=1',
    \    '-interaction=nonstopmode',
    \ ],
    \}

" Copilot configuration
let g:copilot_enabled = v:false
"let g:copilot_enabled = 0
let g:copilot_filetype = {
	  \ 'md': v:false,
	  \ }
let g:copilot_workspace_folders =
	   \ ["~/Documents/docker_storage/ros-humble-nvidia"]
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

