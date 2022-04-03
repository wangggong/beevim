"******************************************************************************"

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
if has('nvim')
    call plug#begin(stdpath('data') . '/plugged')
else
    call plug#begin('$HOME/.local/share/nvim' . '/plugged')
endif

set rtp+=~/.fzf

Plug 'easymotion/vim-easymotion'
Plug 'flazz/vim-colorschemes'
Plug 'gcmt/wildfire.vim'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'luochen1990/rainbow'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-signify'
Plug 'micha/vim-colors-solarized'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
" Plug 'skywind3000/gutentags_plus'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

"******************************************************************************"

"******************************************************************************"

" From https://github.com/neoclide/coc.nvim/blob/master/README.md

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap  <silent>  [g  <Plug>(coc-diagnostic-prev)
nmap  <silent>  ]g  <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gD <Plug>(coc-references)
nmap <silent> gd <Plug>(coc-definition)

" Use K to show documentation in preview window.
nnoremap  <silent>  K  :call  <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Apply AutoFix to problem on the current line.

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

"******************************************************************************"

"******************************************************************************"

" From https://github.com/junegunn/fzf/blob/master/README-VIM.md

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction

let g:fzf_action = {
            \ 'ctrl-q': function('s:build_quickfix_list'),
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right / window
let g:fzf_layout = { 'window' : {'width': 0.9, 'height': 0.9} }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

function! s:projSwtch(path)
    exec "lcd " . a:path
    call fzf#vim#files(a:path, fzf#vim#with_preview())
endfunction

command! -nargs=* -bang ProjectSwitchHelper call s:projSwtch(<q-args>)

command! -bang ProjectSwitch call fzf#run({
            \ 'sink'  : 'ProjectSwitchHelper',
            \ 'source': 'cat ' . $PROJ_PATH,
            \ 'window': {'width': 0.9, 'height': 0.9}})
command! -bang ProjectFiles call fzf#vim#files(substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g'), fzf#vim#with_preview(), <bang>0)
command! -bang CurrentFiles call fzf#vim#files(fnameescape(expand('%:h')), fzf#vim#with_preview(), <bang>0)

" From https://github.com/junegunn/fzf.vim:
"   Make fzf completely delegate its search responsibliity to ripgrep process by
"   making it restart ripgrep whenever the query string is updated.
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

function! s:fzf_statusline()
    " Override statusline as you like
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" workspacebuffers - 抄袭自 fzf.vim, 直接把内部函数逻辑搬过来了.
function! s:workspacebuflisted()
    return filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&filetype") != "qf" && match(bufname(v:val), "[0-9a-zA-Z]") == 0')
endfunction

function! s:sort_buffers(...)
    let [b1, b2] = map(copy(a:000), 'get(g:fzf#vim#buffers, v:val, v:val)')
    " Using minus between a float and a number in a sort function causes an error
    return b1 < b2 ? 1 : -1
endfunction

function! s:workspacebuffers(...)
    let [query, args] = (a:0 && type(a:1) == type('')) ?
                \ [a:1, a:000[1:]] : ['', a:000]
    let sorted = sort(s:workspacebuflisted(), 's:sort_buffers')
    let header_lines = '--header-lines=' . (bufnr('') == get(sorted, 0, 0) ? 1 : 0)
    let tabstop = len(max(sorted)) >= 4 ? 9 : 8
    return fzf#run(fzf#vim#with_preview({
                \ 'sink'  : 'e',
                \ 'source': map(sorted, 'bufname(v:val)'),
                \ 'window': {'width': 0.9, 'height': 0.9}}))
endfunction

command! -bar -bang -nargs=? -complete=buffer WorkspaceBuffers  call s:workspacebuffers(<q-args>, fzf#vim#with_preview({ "placeholder": "{1}" }), <bang>0)

"******************************************************************************"

"******************************************************************************"

" From https://zhuanlan.zhihu.com/p/36279445

" " gtags
" let $GTAGSLABEL='native-pygments'
" "let $GTAGSLABEL='new-ctags'
" let $GTAGSCONF ='/usr/local/share/gtags/gtags.conf'
" 
" " gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
" let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 
" " 所生成的数据文件的名称
" let g:gutentags_ctags_tagfile = 'tags'
" 
" " " 同时开启 ctags 和 gtags 支持：
" let g:gutentags_modules = []
" if executable('ctags')
"     let g:gutentags_modules += ['ctags']
" endif
" if executable('gtags-cscope') && executable('gtags')
"     let g:gutentags_modules += ['gtags_cscope']
" endif
" 
" " 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
" let g:gutentags_cache_dir = expand('~/.cache/tags')
" 
" " 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
" let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
" let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
" let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 
" " 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
" let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" 
" " 禁用 gutentags 自动加载 gtags 数据库的行为
" let g:gutentags_auto_add_gtags_cscope = 0
" 
" " change focus to quickfix window after search (optional).
" let g:gutentags_plus_switch = 1
" 
" " 允许 gutentags 打开一些高级命令和选项
" let g:gutentags_define_advanced_commands = 1
" let g:gutentags_plus_nomap = 1

"******************************************************************************"

"******************************************************************************"

" Other custom configuration:
"autocmd FileType c,cpp,go,java,perl,python,rust autocmd BufWritePre * :Format
autocmd BufWritePre *.go :Format

autocmd FileType go nnoremap <buffer> [[ 0?^func <CR>:nohl<CR>
autocmd FileType go nnoremap <buffer> ]] 0/^func <CR>:nohl<CR>

autocmd FileType php setl makeprg=rm\ -rf\ vendor\ &&\ rm\ -rf\ composer.lock\ &&\ composer\ -vvv\ update

"autocmd BufEnter *.php let  $GTAGSLABEL='native'
"autocmd BufLeave *.php let  $GTAGSLABEL='native-pygments'

autocmd FileType fugitive nnoremap <buffer> bb   :G checkout 
autocmd FileType fugitive nnoremap <buffer> fa   :G fetch    -a   <CR>
autocmd FileType fugitive nnoremap <buffer> fp   :G fetch    <CR>
autocmd FileType fugitive nnoremap <buffer> Fp   :G pull     <CR>
autocmd FileType fugitive nnoremap <buffer> F-rp :G pull     -r   <CR>
autocmd FileType fugitive nnoremap <buffer> me   :G merge 
autocmd FileType fugitive nnoremap <buffer> mm   :G merge    <CR>
autocmd FileType fugitive nnoremap <buffer> pp   :G push     <CR>
autocmd FileType fugitive nnoremap <buffer> re   :G rebase 
autocmd FileType fugitive nnoremap <buffer> rr   :G rebase   <CR>
autocmd FileType fugitive nnoremap <buffer> Zp   :G stash    pop<CR>
autocmd FileType fugitive nnoremap <buffer> Zz   :G stash    <CR>

scriptencoding utf-8

if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

set  background=dark
set  clipboard=unnamed
set  cmdheight=2
set  colorcolumn=80,120
set  cursorline
set  expandtab
set  foldenable
set  hidden
set  ignorecase
set  linespace=0
set  list
set  listchars=tab:\|>,trail:-,extends:>,precedes:<,nbsp:+,lead:.
set  mouse=""
set  mousehide
set  nobackup
set  nojoinspaces
set  nomore
set  nospell
set  noswapfile
set  nowrap
set  nowritebackup
set  nrformats-=octal
set  pastetoggle=<F12>
set  relativenumber
set  rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set  scrolljump=5
set  scrolloff=3
set  shiftwidth=4
set  shortmess+=c
set  showcmd
set  showmatch
set  showmode
set  smartcase
set  smartindent
set  softtabstop=4
set  splitbelow
set  splitright
set  t_Co=256
set  tabpagemax=15
set  tabstop=4
set  updatetime=300
set  whichwrap=b,s,h,l,<,>,[,]
set  wildmode=list:longest,full
set  winminheight=0

" Broken down into easily includeable segments
set  statusline=%<%f\                      " Filename
set  statusline+=%w%h%m%r                  " Options
set  statusline+=%{fugitive#statusline()}  " Git Hotness
set  statusline+=\ [%{&ff}/%Y]             " Filetype
set  statusline+=\ [%{getcwd()}]           " Current dir
set  statusline+=%=%-14.(%l,%c%V%)\ %p%%   " Right aligned file nav info

if has('nvim')
    let $RC="$HOME/.config/nvim/init.vim"
else
    let $RC="$HOME/.vimrc"
endif

let  $DEFAULT_PROJ_PATH="~/Code/src/git.xiaojukeji.com"
let  $PROJ_PATH="~/.project.paths"
let  $RTP=split(&runtimepath,  ',')[0]
let  $SESSION_FILE="~/.session"
"let  g:airline_theme='base16_monokai'
let  g:airline_theme='molokai'
"let  g:airline_theme='onedark'
let  g:indent_guides_enable_on_vim_startup=1
let  g:rainbow_active=1
let  g:solarized_contrast="normal"
let  g:solarized_termcolors=256
let  g:solarized_termtrans=1
let  g:solarized_visibility="normal"
let  g:wildfire_objects=["iw", "iW", "i'", 'i"', "i)", "i]", "i}", "ip", "it"]
let  mapleader=" "

hi  IndentGuidesEven  ctermbg=lightgrey
hi  IndentGuidesOdd   ctermbg=darkgrey
hi  clear             LineNr             " Current line number row will have same background color in relative mode
hi  clear             SignColumn         " SignColumn should match background

colorscheme molokai
"colorscheme nofrils-acme
"colorscheme onedark

" hi  Normal            ctermbg=none       " Kill the background

syntax on

" GDB:
packadd termdebug

map  gs  <Plug>(easymotion-prefix)
map  zl  zL
map  zh  zH

map  <leader>mfc    /\v^[<\|=>]{7}( .*\|$)<CR>
map  <leader>.      :CurrentFiles<CR>

cmap cwd lcd %:p:h
cmap w!! w   !sudo tee % >/dev/null

cnoremap cdpr lcd <C-R>=substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')<CR>

nnoremap zpr  :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>:set foldmethod=manual<CR><CR>
nnoremap z{   zfi{
nnoremap z[   zfi[
nnoremap z(   zfi(
nnoremap Z{   zfa{
nnoremap Z[   zfa[
nnoremap Z(   zfa(

noremap  j  gj
noremap  k  gk

nnoremap <C-_> :UndotreeToggle<CR>
nnoremap <C-f> [I:let      nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
nnoremap Y     y$

nmap <leader>ca <Plug>(coc-codeaction)
nmap <leader>cc :make<CR>
nmap <leader>cf :Format<CR>
nmap <leader>ci <Plug>(coc-implementation)
nmap <leader>ck :call  <SID>show_documentation()<CR>
nmap <leader>co :OR<CR>
nmap <leader>cr <Plug>(coc-rename)
nmap <leader>ct <Plug>(coc-type-definition)
nmap <leader>qf <Plug>(coc-fix-current)

if has('nvim')
    nnoremap  <leader>'  :split<CR>:terminal<CR>i
else
    nnoremap  <leader>'  :terminal<CR>
endif

nnoremap <leader>,   :WorkspaceBuffers<CR>
nnoremap <leader>0   1gtgT
nnoremap <leader>1   1gt
nnoremap <leader>2   2gt
nnoremap <leader>3   3gt
nnoremap <leader>4   4gt
nnoremap <leader>5   5gt
nnoremap <leader>6   6gt
nnoremap <leader>7   7gt
nnoremap <leader>8   8gt
nnoremap <leader>9   9gt
nnoremap <leader>=   :NERDTreeToggle<CR>
nnoremap <leader>bB  :Buffers<CR>
nnoremap <leader>bb  :WorkspaceBuffers<CR>
nnoremap <leader>bd  :bdelete<CR>
nnoremap <leader>cm  :<C-u>CocList         outline<cr>
nnoremap <leader>ff  :Files<CR>
nnoremap <leader>fp  :vsplit               $RC<CR>
nnoremap <leader>fs  :w<CR>
nnoremap <leader>gB  :Git blame<CR>
nnoremap <leader>gg  :Git<CR>
nnoremap <leader>hrr :source               $RC<CR>
nnoremap <leader>ht  :Colors<CR>
nnoremap <leader>pf  :ProjectFiles<CR>
nnoremap <leader>pp  :ProjectSwitch<CR>
nnoremap <leader>qL  :source               $SESSION_FILE<CR>
nnoremap <leader>qS  :mksession!           $SESSION_FILE<CR>
nnoremap <leader>sB  :Lines<CR>
nnoremap <leader>sb  :BLines<CR>
nnoremap <leader>tT  :Tags<CR>
nnoremap <leader>ta  :GscopeFind           a                 <C-R><C-W><CR>
nnoremap <leader>tc  :GscopeFind           c                 <C-R><C-W><CR>
nnoremap <leader>td  :GscopeFind           d                 <C-R><C-W><CR>
nnoremap <leader>te  :GscopeFind           e                 <C-R><C-W><CR>
nnoremap <leader>tf  :GscopeFind           f                 <C-R>=expand("<cfile>")<CR><CR>
nnoremap <leader>tg  :GscopeFind           g                 <C-R><C-W><CR>
nnoremap <leader>ti  :GscopeFind           i                 <C-R>=expand("<cfile>")<CR><CR>
nnoremap <leader>ts  :GscopeFind           s                 <C-R><C-W><CR>
nnoremap <leader>tt  :GscopeFind           t                 <C-R><C-W><CR>
nnoremap <leader>tz  :GscopeFind           z                 <C-R><C-W><CR>
nnoremap <leader>w+  <C-w>+
nnoremap <leader>w-  :split<CR>
nnoremap <leader>w/  :vsplit<CR>
nnoremap <leader>w<  <C-w><
nnoremap <leader>w>  <C-w>>
nnoremap <leader>w_  <C-w>_
nnoremap <leader>wd  :quit<CR>
nnoremap <leader>wh  <C-w>h
nnoremap <leader>wj  <C-w>j
nnoremap <leader>wk  <C-w>k
nnoremap <leader>wl  <C-w>l
nnoremap <leader>wt  :tabnew<CR>:lcd<CR>
nnoremap <leader>ww  <C-w>w

nnoremap <silent> <leader>/ :RG <C-r><C-w><CR>

vnoremap  .  :normal  .<CR>
vnoremap  <  <gv
vnoremap  >  >gv

"******************************************************************************"

