"--------------------------Plugins used -------------------------------

call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim'  " Auto Completion
Plug 'lervag/vimtex'
Plug 'morhetz/gruvbox'
Plug 'godlygeek/tabular' 
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/vim-markdown'
"Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
"Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
"Plug 'vim-pandoc/vim-pandoc'

call plug#end()


"---------------------------General Settings ------------------------

set relativenumber
set number
set termguicolors
set smartindent
set noerrorbells
set incsearch
set signcolumn=no
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set cursorline
set conceallevel=2
set path+=**
set wildmenu
colorscheme gruvbox
set bg=dark
syntax enable

"coc configuration

" coc configuration

let g:coc_global_extensions = [
  \ 'coc-pairs', 
  \ 'coc-pyright',
  \ 'coc-texlab',
  \ ]

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Mardown COnfiguration

let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 2
let g:mkdp_refresh_slow = 1
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }
" Tabularize configuration

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

let g:vimtex_view_method = 'zathura'

