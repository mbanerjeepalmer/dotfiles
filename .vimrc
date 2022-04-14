execute pathogen#infect()
execute pathogen#helptags()

call plug#begin()
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'vimwiki/vimwiki'
Plug 'sheerun/vim-polyglot'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'codechips/coc-svelte', {'do': 'npm install'}
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
Plug 'Shougo/context_filetype.vim'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdcommenter'
Plug 'tools-life/taskwiki' 
Plug 'ambv/black'
call plug#end()

" Prettier Settings
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat_require_pragma = 0
au BufWritePre *.css,*.svelte,*.pcss,*.html,*.ts,*.js,*.json PrettierAsync

set hlsearch    " highlight all search results
set ignorecase  " do case insensitive search 
set incsearch   " show incremental search results as you type
set number      " display line number
set noswapfile  " disable swap file
set nocompatible
filetype plugin on
syntax on

let g:vimwiki_list = [{'path': '~/Dropbox/Personal/Documents/Record/md/', 'html_path':'~/Dropbox/Personal/Documents/Record/md/html','syntax': 'markdown', 'ext': '.md'}]

let g:vimwiki_global_ext = 1
" To support Markor's links https://github.com/vimwiki/vimwiki/pull/529
let g:vimwiki_markdown_link_ext = 1

let g:GPGPreferSymmetric = 1

:inoremap jj <Esc>

" :set tabstop=4
" :set shiftwidth=4
" :set expandtab

" Get .vimrc based on current folder
:set exrc


" Svelte Vim comments - https://codechips.me/vim-setup-for-svelte-development/
if !exists('g:context_filetype#same_filetypes')
  let g:context_filetype#filetypes = {}
endif

let g:context_filetype#filetypes.svelte =
\ [
\   {'filetype' : 'javascript', 'start' : '<script>', 'end' : '</script>'},
\   {
\     'filetype': 'typescript',
\     'start': '<script\%( [^>]*\)\? \%(ts\|lang="\%(ts\|typescript\)"\)\%( [^>]*\)\?>',
\     'end': '',
\   },
\   {'filetype' : 'css', 'start' : '<style \?.*>', 'end' : '</style>'},
\ ]

let g:ft = ''

" NERDCommenter settings - via codechips https://codechips.me/vim-setup-for-svelte-development/

 if !exists('g:context_filetype#same_filetypes')
   let g:context_filetype#filetypes = {}
 endif

 let g:context_filetype#filetypes.svelte =
 \ [
 \   {'filetype' : 'javascript', 'start' : '<script \?.*>', 'end' : '</script>'},
 \   {
 \     'filetype': 'typescript',
 \     'start': '<script\%( [^>]*\)\? \%(ts\|lang="\%(ts\|typescript\)"\)\%( [^>]*\)\?>',
 \     'end': '',
 \   },
 \   {'filetype' : 'css', 'start' : '<style \?.*>', 'end' : '</style>'},
 \ ]

 let g:ft = ''

" " Settings: NERDCommenter

let g:NERDCustomDelimiters = { 'html': { 'left': '<!--', 'right': '-->' } }

fu! NERDCommenter_before()
  if (&ft == 'html') || (&ft == 'svelte')
  let g:ft = &ft
  let cfts = context_filetype#get_filetypes()
  if len(cfts) > 0
    if cfts[0] == 'svelte'
      let cft = 'html'
    elseif cfts[0] == 'scss'
      let cft = 'css'
    else
      let cft = cfts[0]
    endif
    exe 'setf ' . cft
    endif
  endif
endfu

fu! NERDCommenter_after()
  if (g:ft == 'html') || (g:ft == 'svelte')
  exec 'setf ' . g:ft
  let g:ft = ''
  endif
endfu


" Run Black on save.
autocmd BufWritePre *.py execute ':Black'
