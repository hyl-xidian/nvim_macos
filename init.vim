""                                  _                    
""       _ __ ___  _   _     __   _(_)_ __ ___  _ __ ___ 
""      | '_ ` _ \| | | |____\ \ / / | '_ ` _ \| '__/ __|
""      | | | | | | |_| |_____\ V /| | | | | | | | | (__ 
""      |_| |_| |_|\__, |      \_/ |_|_| |_| |_|_|  \___|
""                 |___/                                 

" 0. Preparation {{{
" 1. install through brew or pacman
" Ripgrep
" fzf
" ctags
" $ brew tap universal-ctags/universal-ctags
" $ brew install --HEAD universal-ctags/universal-ctags/universal-ctags
" 2. Hooks after plugins installation
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" 3. others
" 'ranger.vim' delete a function mapped with '<LEADER>f'
" when not in linux system, uncomment the Fcitx Control.

" define 'space' as <LEADER>
let mapleader=" "


if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}

" 0. Plugins {{{
" Install {{{
"" ===
"" install plug
"" ===

call plug#begin('~/.config/nvim/plugged')

" color scheme
Plug 'theniceboy/nvim-deus'

" input method switch for macos
Plug 'ybian/smartim'

" tab&buffer bar style
Plug 'mg979/vim-xtabline'

Plug 'bling/vim-bufferline'

" syntax
Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['cpp']}
Plug 'uiiaoo/java-syntax.vim', {'for': ['java']}

" Undo Tree
Plug 'mbbill/undotree'
" Git status plug
Plug 'airblade/vim-gitgutter'

"" FZF
""" Attention:fzf requirs Neovim 0.4+
""" Dependency:Ripgrep
""" INSTALL: for Ubuntu 18.04
""" curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
""" sudo dpkg -i ripgrep_12.1.1_amd64.deb
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Ranger
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'

"" wildfire + surround
" With Wildfire you can quickly select the closest text object among a group of candidates.
Plug 'gcmt/wildfire.vim'
" Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML tags, and more. The plugin provides mappings to easily delete, change and add such surroundings in pairs.
Plug 'tpope/vim-surround'
" Multi cursor
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Auto pairs
Plug 'jiangmiao/auto-pairs', {'for': ['java', 'cpp', 'python', 'go']}
" highlight
Plug 'RRethy/vim-illuminate', {'for': ['java', 'cpp', 'vim-plug']}

"" Markdown
" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" markdown table mode
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
" Markdown TOC
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown'] }

"" code plugs
" coc.nvim
Plug 'neoclide/coc.nvim',{'branch': 'release'}
" vista
Plug 'liuchengxu/vista.vim'

" devicons
Plug 'ryanoasis/vim-devicons'
call plug#end()
function! s:plug_loaded(spec)
let rtp = join(filter([a:spec.dir, get(a:spec, 'rtp', '')], 'len(v:val)'), '/')
return stridx(&rtp, rtp) >= 0 && isdirectory(rtp)
endfunction

function! s:plug_names(...)
return sort(filter(keys(filter(copy(g:plugs), { k, v -> !s:plug_loaded(v) })), 'stridx(v:val, a:1) != -1'))
endfunction

command! -nargs=+ -bar -complete=customlist,s:plug_names PlugLoad call plug#load([<f-args>])
"}}}

" Configurations {{{
"" ===
"" === Smartim
"" ===
let g:smartim_default='com.apple.keylayout.ABC'


"" "" ===
"" "" === Netrw
"" "" ===
"" nnoremap <LEADER>e :Vexplore<CR>
"" " 25% of the window
"" let g:netrw_winsize=25
"" " 0 means No Banner!
"" " 'I' key: Toggle the displaying of the banner
"" let g:netrw_banner=0
"" "" 1. Use the horizontal split window to open the file
"" "" 2. Vertically split the window to open the file
"" "" 3. Open the file with a new tab
"" "" 4. Use the previous window to open the file
"" let g:netrw_browse_split=4
"" " 'i' key: Cycle between thin, long, wide, and tree listings
"" ""liststyle:thin/long/wide/tree
"" let g:netrw_liststyle=3


"" ===
"" === Buffer line
"" ===
"let g:bufferline_active_buffer_left = '{'
"let g:bufferline_active_buffer_right = '}'
let g:bufferline_modified = '+'


" ===
" === xtabline
" ===
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
"noremap to :XTabCycleMode<CR>
noremap \p :echo expand('%:p')<CR>


" ===
" === Undotree
" ===
nnoremap <LEADER>u :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
nmap <buffer> k <plug>UndotreeNextState
nmap <buffer> j <plug>UndotreePreviousState
nmap <buffer> K 5<plug>UndotreeNextState
nmap <buffer> J 5<plug>UndotreePreviousState
endfunc


"" ===
"" git status plug
"" vim-gitgutter
"" ===
"" You can jump between hunks with [c and ]c. You can preview, stage, and undo
"" hunks with <LEADER>hp, <LEADER>hs, and <LEADER>hu respectively.
" remove the limits of the size of signs
let g:gitgutter_max_signs = -1
" make background colours match the sign column
let g:gitgutter_set_sign_backgrounds = 1
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)


" ===
" === FZF
" ===
" Search in files in the current directory
nnoremap <silent> <C-p> :Files<CR>
" Search in use ripgrep
" `sudo pacman -S ripgrep`
nnoremap <silent> <C-f> :Rg<CR>
"" Search in ctags
"noremap <C-t> :BTags<CR>
" Search in lines of the current file
nnoremap <silent> <C-l> :Lines<CR>
" Search in buffers
nnoremap <silent> <C-b> :Buffers<CR>
" History of opened files
nnoremap <silent> <C-h> :History<CR>
" Commands History
nnoremap <LEADER>; :History:<CR>

let g:fzf_preview_window = 'right:60%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }


" ===
" === vim-illuminate
" ===
let g:Illuminate_delay = 550
hi illuminatedWord cterm=undercurl gui=undercurl


" ===
" === vim visual multi
" ===

" Next/Previous/Skip           n / N / q

let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n
let g:VM_maps["Select Cursor Down"] = '<M-C-Down>'      " start selecting down
let g:VM_maps["Select Cursor Up"]   = '<M-C-Up>'        " start selecting up
"let g:VM_leader                     = {'default': ',', 'visual': ',', 'buffer': ','}
let g:VM_maps["Select All"]                  = '\\a'
let g:VM_maps["Start Regex Search"]          = '\\/'
let g:VM_maps["Visual Regex"]                = '\\/'
let g:VM_maps["Visual All"]                  = '\\a'
let g:VM_maps["Visual Find"]                 = '\\f'
let g:VM_maps["Visual Cursors"]              = '\\c'


"" ===
"" === Ranger
"" ===
nnoremap <LEADER>o :RangerCurrentDirectoryNewTab<CR>
"nnoremap <LEADER>n :RangerCurrentFile<CR>


"" ===
"" === vim table mode for markdown
"" ===
map tm :TableModeToggle<CR>


"" ===
"" === Markdown preview
"" ===
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
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
\ 'disable_filename': 0,
\ 'toc': {}
\ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
let g:mkdp_theme = 'dark'


"}}}

" Code conifg {{{
" Coc config {{{
"" ===
"" === Coc config
"" ===

" Some servers have issues with backup files, see #649
"set nobackup
"set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
"set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=number

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                          \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"" Use <c-space> to trigger completion
"if has('nvim')
"  inoremap <silent><expr> <c-o> coc#refresh()
"else
"  inoremap <silent><expr> <c-@> coc#refresh()
"endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> H :call ShowDocumentation()<CR>

function! ShowDocumentation()
if CocAction('hasProvider', 'hover')
call CocActionAsync('doHover')
else
call feedkeys('K', 'in')
endif
endfunction

" Highlight the symbol and its references when holding the cursor
"autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
autocmd!
" Setup formatexpr specified filetype(s)
autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" Update signature help on jump placeholder
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"" Mappings for CoCList
"" Show all diagnostics
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"" Show commands
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document
"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

nmap tt :CocCommand explorer<CR>
" }}}

" others {{{
" ===
" === vista
" ===
" vista toggle
nnoremap vv :Vista!!<CR>
" :Vista finder [EXECUTIVE]: search tags/symbols generated from EXECUTIVE.
" NOTE: this function requirs 0.22.0 or above
nnoremap vf :Vista finder<CR>

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'ctags'
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

" }}}
" }}}
" }}}

" 1. Appereance {{{
set background=dark
let $LANG = 'en_US'

"color koehler
"color molokai
"color gruvbox
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
silent! color deus
hi NonText ctermfg=gray guifg=grey10

" For gvim
set guifont=SauceCodePro\ Nerd\ Font\ Mono\ 14

" Displays the Status Line on the second to last line of the window
set laststatus=2

" Set the statusline
" Reference:https://zhuanlan.zhihu.com/p/25494323
" Preview all highlight groups with `:so $VIMRUNTIME/syntax/hitest.vim
set statusline=
"set statusline+=%#Normal#
"set statusline+=%{StatuslineGit()}
"set statusline+=%#Keyword#
set statusline+=%#StatusLine#
set statusline+=\ %F
set statusline+=%#Keyword#
set statusline+=%m\ %r
set statusline+=%#Normal#
set statusline+=%=
set statusline+=[%l,%c]
set statusline+=\ 
set statusline+=%#Keyword#
set statusline+=\ 
set statusline+=\ %p%%\ 
set statusline+=%#Normal#
set statusline+=\|\ 
set statusline+=\ %{&fileformat}:%{&fileencoding?&fileencoding:&encoding}
set statusline+=%#Keyword#
set statusline+=\ %y

function! InsertStatuslineColor(mode)
if a:mode == 'i'
  hi StatusLine ctermbg=238
  hi StatusLine ctermfg=109
elseif a:mode == 'r'
  hi StatusLine ctermfg=208
endif
endfunction
au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi StatusLine ctermbg=223 ctermfg=239
" }}}

" 2. Editor Behavior {{{
"" ===
"" === Editor Behavior
"" ===
"
"" ===
"" TWO important settings
"" ===

"" The length of time Vim waits after you stop typing before it triggers the plugin is governed by the setting updatetime.
"" DEFAULT:4000(ms)
"
"" Affected functions:
"" vim-gitgutter
"" vimspector
"" ...
" set updatetime=200
set updatetime=150
" set updatetime=600

"" Key-specific timeoutlen in vim
"" Example: In normal mode, the 'b' key has been bound to Buffer related operations. Like:bd
"" bs, but 'b' key also has its default functions--'go back to the previous
"" word'. So there will be a short delay everytime you press the 'b' key.
""
"" 'timeoutlen' is the length of the delay time.
"" The keys you have typed during the delay time will be identified as
"" 'Specific-key'
"" Example: if you type 'b' and 'd' within TIMEOUTLEN, the vim will trigger
"" 'buffer down'
""
"" Affected bindings:
"" 'oh oj ok ol' and 'o'
"" 'bh bj bk bl bs bd' and 'b'
set timeoutlen=500
nnoremap B b
nnoremap O o
nnoremap o <nop>

" 在macos下开启鼠标
set mouse=a

""" Do not load the 'matchparen' plugin
""" Path: /usr/share/vim/vim82/plugin/matchparen.vim
""" Describe: Highlight the matching brackets
""let loaded_matchparen = 1
""
""" Turn off the bracket matching
""" '%' go to the previous bracket
""set noshowmatch

set lazyredraw
set ttyfast

"" Make the configuration file take effect immediately
"autocmd BufWritePost $MYVIMRC source $MYVIMRC

"" Automatically matches the right bracket when you enter a left bracket
"set showmatch

" set autoread
" set autowriteall

" Display the current line number
set number
" Display relative line numbers
set relativenumber
" Show the line numbers(absolute) of the line 
" where the cursor is located
set ruler

" Highlight the line/column where the cursor is located
"set cursorline
"set cursorcolumn

" Show invisible characters
set list
" Set which symbol to display invisible characters
set listchars=tab:>-,trail:-

" Syntax highlighting
syntax on

" C++ indent
set cindent
"set smartindent

" Tab key:The increased indent will be converted to 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Search:
" Highlight matching results
set hlsearch
" Enter a character and match it automatically
set incsearch

" Search for content that contains uppercase characters, it performs a case sensitive search;
" if it searches for content that is only lowercase, it performs a case insensitive search
set ignorecase
set smartcase

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Press backspace key on the start of the current line 
" can go back to the previous line
set backspace=indent,eol,start

" Make cursor stay at the last position of last time
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" When scroll up and down, the cursor position is always 6 lines from the 
" top/bottom
set scrolloff=6

" Enable file type checking
filetype on
filetype plugin indent on

" Search down into subfolders
" Provides tab-completion for all file -related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" Create the 'tags' file (may need to install ctags first)
command! MakeTags !ctags -R .

" Set Codings
set fileencodings=utf-8,gbk,ucs-bom,gb18030,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

set hidden

" Retain revocation history
set undofile
set undodir=$HOME/.config/nvim_undofiles
" Stop generating swap files
set noswapfile
set history=1000
set showcmd

set autochdir
" Auto change directory to current dir
"autocmd BufEnter * silent! lcd %:p:h
"" Correct spelling
"set spell

" }}}

" 3. Key Mappings {{{
" Basic Mappings {{{
"" ===
"" === Basic Mappings
"" ===
"" Attention!!!!
"" Don't bind any insert-mode operations to <LEADER>!!!!
"" If you are using <SPACE> as mapleader

" Press <SPACE> twice to jump to the next '<++>' and edit it
" as similiar as a place-holder
nnoremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" space + enter means no high light, very useful!!!!
nnoremap <LEADER><CR> :nohlsearch<CR>

" copy/paste to the System clipboard
"

"Nvim has no direct connection to the system clipboard. Instead it depends on
"a |provider| which transparently uses shell commands to communicate with the
"system clipboard or any other clipboard "backend".
"
" BACKEND: xclip or xsel(if $DISPLAY is set)
"
"" ctrl + ;
"" open a memu to select contents from history system clipboard
"" <Tab> to switch around results
"" <Space> to paste the chosen contents
vnoremap <LEADER>y "+y
nnoremap <LEADER>p "+p

" Press F4 to toggle syntax
nnoremap <F4> :exec exists('syntax_on') ? 'syn off': 'syn on'<CR>

" " Faster save and quit
nnoremap S :w<CR>

nnoremap ; :
"}}}

" Cursor Movement {{{
"" ===
"" === Cursor Movement
"" ===
" Faster in-line navigation
noremap K 5k
noremap J 5j

" Copy from the cursor location to the end of the line
nnoremap Y y$

"" 0 key: go to the start of the current line
"" $ key: go to the end of the current line
"}}}

" Command Mode Cursor Movement {{{
"" ===
"" === Command Mode Cursor Movement
"" ===
cnoremap <C-h> <Left>
cnoremap <C-l> <End>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
"}}}

" Window Management {{{
"" ===
"" === Window Management
"" ===
" Use <space> + new arrow keys for moving the cursor around windows
nmap <LEADER>h <C-w>h
nmap <LEADER>l <C-w>l
nmap <LEADER>j <C-w>j
nmap <LEADER>k <C-w>k

" Disable the default s key
map s <nop>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical) and open a new file with ranger
noremap ok :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap oj :set splitbelow<CR>:split<CR>
noremap oh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap ol :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Place the two screens up and down
noremap sh <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H

" Press <SPACE> + q to close the window below the current window
nnoremap <LEADER>q <C-w>j:q<CR>
"}}}

" Tab Management {{{
"" ===
"" === Tab Management
"" ===
" move around tabs with 'th' and 'tl'
nmap tl :+tabnext<CR>
nmap th :-tabnext<CR>
" open a new tab
nmap tn :tabnew<CR>
" fuzzy search in a new tab
nmap <LEADER>f :FZF!<CR>
"}}}

" Buffer Management {{{

"" :ls b --Show all exited buffers
"" :b NUM --Specify the NUMth buffer
" Buffer Previous
nnoremap bh :bp<CR>
" Buffer Next
nnoremap bl :bn<CR>
" Buffer Down --Shutdown the current buffer
nnoremap bd :bd<CR>
" List the buffers
nnoremap bs :ls b<CR>
"}}}

" }}}

" 4. Useful Functions {{{

" CompileRunGcc {{{
func! CompileRunGcc()
exec "w"
if &filetype == 'c'
exec "!g++ % -o %<"
exec "!time ./%<"
elseif &filetype == 'cpp'
set splitbelow
exec "!g++ -g -std=c++17 % -Wall -o %<"
:sp
:res -8
:term ./%<
elseif &filetype == 'java'
set splitbelow
exec "!javac -g %"
:sp
:res -8
:term java %<
elseif &filetype == 'sh'
:!time bash %
elseif &filetype == 'python'
set splitbelow
:sp
:term python3 %
elseif &filetype == 'html'
exec "!".g:mkdp_browser." % &"
elseif &filetype == 'markdown'
exec "MarkdownPreview"
elseif &filetype == 'javascript'
set splitbelow
:sp
:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
elseif &filetype == 'go'
set splitbelow
:sp
:term go run .
endif
endfunc

noremap <C-r> :call CompileRunGcc()<CR><C-w>k
"}}}

" Git-Branch Name {{{
"" ===
"" === Get the name of git branch
"" ===
function! GitBranch()
return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
let l:branchname = GitBranch()
return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction
"}}}
" }}}

" 5. Snippets {{{
" Markdown Snippets {{{
"" autocmd Filetype markdown inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>c4l
"" "autocmd Filetype markdown inoremap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>c5l<CR>
"" autocmd Filetype markdown inoremap <buffer> ,b **** <++><Esc>F*hi
"" autocmd Filetype markdown inoremap <buffer> ,s ~~~~ <++><Esc>F~hi
"" autocmd Filetype markdown inoremap <buffer> ,i ** <++><Esc>F*i
"" autocmd Filetype markdown inoremap <buffer> ,d `` <++><Esc>F`i
"" autocmd Filetype markdown inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
"" autocmd Filetype markdown inoremap <buffer> ,n - [ ] 
"" autocmd Filetype markdown inoremap <buffer> ,p ![](<++>) <++><Esc>F[a
"" autocmd Filetype markdown inoremap <buffer> ,a [](<++>) <++><Esc>F[a
"" autocmd Filetype markdown inoremap <buffer> ,1 #<Space><Enter><++><Esc>kA
"" autocmd Filetype markdown inoremap <buffer> ,2 ##<Space><Enter><++><Esc>kA
"" autocmd Filetype markdown inoremap <buffer> ,3 ###<Space><Enter><++><Esc>kA
"" autocmd Filetype markdown inoremap <buffer> ,4 ####<Space><Enter><++><Esc>kA
"" autocmd Filetype markdown inoremap <buffer> ,l --------<Enter>
"}}}

" }}}

" vim:set fdm=marker:
