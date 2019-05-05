set nocompatible
set shell=bash\ -l
set path=**
set title
let g:netrw_keepdir= 2
set noswapfile
set guifont=DejaVu\ Sans:s12
set paste
set pastetoggle=<F2>
set rnu
set number
set t_Co=256        	"set colors to 256
syntax enable		"use syntax highlighting

" --- convert selected text from markdown to HTML ---
vnoremap <silent> <leader>md :! mdown<CR>
function! SanitizeMdown()
    %s/<\/\?p>//
	%s/<br \?\/\?>/ /
    %s/<pre><code>/<pre class="brush:js">\r/
    %s/<\/code><\/pre>/<\/pre>/
endfunc
noremap <silent> <leader>mds :call SanitizeMdown()<CR>

" nnoremap ; : removes need for <shift>:
noremap ; :
noremap : ;

" --- format JavaScript source code using esformatter --

nnoremap <silent> <leader>es :Esformatter<CR>
vnoremap <silent> <leader>es :EsformatterVisual<CR>

" --- toggle autocomplete behavior and word delimiters ---

function! KeywordsAll()
    setl iskeyword=@,48-57,192-255,\@,\$,%,-,_
endfunc

function! KeywordsBasic()
    setl iskeyword=@,48-57,192-255
endfunc

" --- visual block move ---

let g:DVB_TrimWS = 1
vmap  <expr>  <S-LEFT>   DVB_Drag('left')
vmap  <expr>  <S-RIGHT>  DVB_Drag('right')
vmap  <expr>  <S-DOWN>   DVB_Drag('down')
vmap  <expr>  <S-UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

" Local dirs (centralize everything)
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
" Change mapleader (easier to type), at the top since its used everywhere
let mapleader=","
let maplocalleader=";"

set spelllang=en_us         " spell checking
set encoding=utf-8 nobomb   " BOM often causes trouble, UTF-8 is awsum.
" --- performance / buffer ---
set hidden                  " can put buffer to the background without writing
"   to disk, will remember history/marks.
set lazyredraw              " don't update the display while executing macros
set ttyfast                 " Send more characters at a given time.


" --- history / file handling ---
set history=999             " Increase history (default = 20)
set undolevels=999          " Moar undo (default=100)
set autoread                " reload files if changed externally


" --- backup and swap files ---
" I save all the time, those are annoying and unnecessary...
set nobackup
set nowritebackup
set noswapfile

" --- search / regexp ---
set gdefault                " RegExp global by default
set magic                   " Enable extended regexes.
set hlsearch                " highlight searches
set incsearch               " show the `best match so far' astyped
set ignorecase smartcase    " make searches case-insensitive, unless they
"   contain upper-case letters

" --- keys ---
set backspace=indent,eol,start  " allow backspacing over everything.
set esckeys                     " Allow cursor keys in insert mode.
set nostartofline               " Make j/k respect the columns
" set virtualedit=all            " allow the cursor to go in to 'invalid' places
set timeoutlen=500              " how long it wait for mapped commands
set ttimeoutlen=100             " faster timeout for escape key and others
set cursorline              " Highlight current line
set laststatus=2            " Always show status line
set number                  " Enable line numbers.
set numberwidth=5           " width of numbers line (default on gvim is 4)
set report=0                " Show all changes.
set showmode                " Show the current mode.
set showcmd                 " show partial command on last line of screen.
set showmatch               " show matching parenthesis
set splitbelow splitright   " how to split new windows.
set title                   " Show the filename in the window title bar.

set scrolloff=5             " Start scrolling n lines before horizontal
"   border of window.
set sidescrolloff=7         " Start scrolling n chars before end of screen.
set sidescroll=1            " The minimal number of columns to scroll
"   horizontally.

" add useful stuff to title bar (file name, flags, cwd)
" based on @factorylabs
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f
    set titlestring+=%h%m%r%w
    set titlestring+=\ -\ %{v:progname}
    set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}
endif

" use relative line number by default
if exists('+relativenumber')
    set relativenumber
endif

" --- command completion ---
set wildmenu                " Hitting TAB in command mode will
set wildchar=<TAB>          "   show possible completions.
set wildmode=list:longest
set wildignore+=*.DS_STORE,*.db,node_modules/**,*.jpg,*.png,*.gif

" --- diff ---
set diffopt=filler          " Add vertical spaces to keep right
"   and left aligned.
set diffopt+=iwhite         " Ignore whitespace changes.


" --- folding---
set foldmethod=manual       " manual fold
set foldnestmax=3           " deepest fold is 3 levels
set nofoldenable            " don't fold by default


" --- list chars ---
" list spaces and tabs to avoid trailing spaces and mixed indentation
" see key mapping at the end of file to toggle `list`
set listchars=tab:▹\ ,trail:·,nbsp:⚋
set fillchars=fold:-
set list


" --- remove sounds effects ---
set noerrorbells
set visualbell

" -----------------------------------------------------------------------------
" INDENTATION AND TEXT-WRAP
" -----------------------------------------------------------------------------
set shiftwidth=4 				"indenting is 4 spaces (should be the same as softtabstop for consistency)
set hidden 						" Allow to write to buffer without writing to disk
set backspace=eol,start,indent
set expandtab                   " Expand tabs to spaces
set autoindent smartindent      " auto/smart indent
set copyindent                  " copy previous indentation on auto indent
set softtabstop=4               " Tab key results in # spaces
set tabstop=4                   " Tab is # spaces

set smarttab                    " At start of line, <Tab> inserts shift width
								"   spaces, <Bs> deletes shift width spaces.

set wrap                        " wrap lines
set textwidth=80
"set colorcolumn=+1             " Show large lines
set formatoptions=qrn1          " automatic formating.
set formatoptions-=o            " don't start new lines w/ comment leader on
"   pressing 'o'

set nomodeline                  " don't use modeline (security)

set pastetoggle=<leader>p       " paste mode: avoid auto indent, treat chars
"   as literal.

" -----------------------------------------------------------------------------
" FILE HANDLING
" -----------------------------------------------------------------------------
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" [autocommands] borrowed from @bit-theory vimfiles and edited
augroup mm_buf_cmds
    " clear commands before resetting
    autocmd!

    " when vimrc is edited, reload it
    autocmd bufwritepost .gvimrc source %
    autocmd bufwritepost .vimrc source %

    " Only show cursorline in the current window and in normal mode
    au WinLeave,InsertEnter * set nocul
    au WinEnter,InsertLeave * set cul

    " filetype
    autocmd BufNewFile,BufRead *.json setf json
    autocmd BufNewFile,BufRead *.hx setf haxe

    autocmd FileType mustache runtime! ftplugin/html/sparkup.vim

    " Enable omnicomplete for supported filetypes
    autocmd FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    " autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    " jscomplete is a separate plugin
    autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " make `gf` search for .js files
    autocmd FileType javascript setlocal suffixesadd=.js
    autocmd FileType javascript setlocal path+=js,scripts


    " make sure `complete` works as expected for CSS class names without
    " messing with motions (eg. '.foo-bar__baz') and we make sure all
    " delimiters (_,-,$,%,.) are treated as word separators outside insert mode
    autocmd InsertEnter,BufLeave * :silent call KeywordsAll()
    autocmd InsertLeave,BufEnter * :silent call KeywordsBasic()

    " yes, we need to duplicate it on VimEnter for some weird reason
    autocmd VimEnter * nnoremap * :silent call KeywordsAll()<CR>
    autocmd VimEnter * nnoremap # :silent call KeywordsAll()<CR>


    " Toggle relative/absolute line numbers during edit
    " if exists('+relativenumber')
    " autocmd InsertEnter * setl nu
    " autocmd InsertLeave,BufEnter * setl rnu
    " endif

    " highlight char at column 81 (textwidth + 1)
    "    autocmd BufEnter * match OverLength /\%81v/

    " Color Column (only on insert)
    if exists("&colorcolumn")
        autocmd InsertEnter * set colorcolumn=80
        autocmd InsertLeave * set colorcolumn=""
    endif
augroup END

"Pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on
"
let g:Powerline_symbols ="fancy"
let g:Powerline_dividers_override =["\Ue0b0","\Ue0b1","\Ue0b2","\Ue0b3"]
let g:Powerline_symbols_override = {'BRANCH':"\Ue0a0",'LINE':"\Ue0a1",'RO':"\Ue0a2"}
let g:airline_powerline_fonts = 1
let g:airline_right_alt_sep =''
let g:airline_right_sep =''
let g:airline_left_alt_sep=''
let g:airline_left_sep =''
"
" " air-line
let g:airline_powerline_fonts = 1
"
if !exists('g:airline_symbols')
     let g:airline_symbols = {}
endif
"
"     " unicode symbols
let g:airline_left_sep ='»'
let g:airline_left_sep ='▶'
let g:airline_right_sep ='«'
let g:airline_right_sep ='◀'
let g:airline_symbols.linenr ='␊'
let g:airline_symbols.linenr ='␤'
let g:airline_symbols.linenr ='¶'
let g:airline_symbols.branch ='⎇'
let g:airline_symbols.paste ='ρ'
let g:airline_symbols.paste ='Þ'
let g:airline_symbols.paste ='∥'
let g:airline_symbols.whitespace ='Ξ'
"
"     " airline symbols
let g:airline_left_sep =''
let g:airline_left_alt_sep =''
let g:airline_right_sep =''
let g:airline_right_alt_sep =''
let g:airline_symbols.branch =''
let g:airline_symbols.readonly =''
let g:airline_symbols.linenr =''


"Airline Themes
"let g:airline_theme='dark'
"let g:airline_theme='badwolf'
"let g:airline_theme='ravenpower'
"let g:airline_theme='simple'
"let g:airline_theme='term'
"let g:airline_theme='ubaryd'
"let g:airline_theme='laederon'
let g:airline_theme='kolor'
"let g:airline_theme='molokai'
"let g:airline_theme='powerlineish'

"colorscheme wombat256
"colorscheme tango
"colorscheme railscasts
"colorscheme vividchalk
"colorscheme distinguished
"colorscheme monokai
"colorscheme molokai
"colorscheme ir_black
"colorscheme neodark
colorscheme kolor
"colorscheme gotham
"colorscheme jellybeans 
"volorscheme desertEx
"colorscheme skittles_berry
"colorscheme skittles_dark
"colorscheme codeblocks_dark
" Display keystrokes in statusline
"set showcmd
set title
"set wrap
"set linebreak

" Display which line the cursor is on
set cursorline
" Tab stops
"	set tabstop=4    	" when you press tab, it will move forward 
						" by 4 spaces
" ----------------------------------------------------------------------
	set shiftwidth=4 	" the number of spaces the >>, <<, >, and < 
						" commands will move by will be 4
" ----------------------------------------------------------------------
	set smarttab 		" pressing backspace on a blank indented line 
						" will delete the amount of spaces equal to 
						" shiftwidth

" Key mappings
	" Set Leader to Space
		let mapleader = "\<Space>"

	" I hate the Escape key
		imap <leader>q \<Esc>
		inoremap jj \<Esc>

	" tab stuff
		nnoremap tn :tabnew<cr>
		nnoremap tk :tabnext<cr>
		nnoremap tj :tabprev<cr>
		nnoremap th :tabfirst<cr>
		nnoremap tl :tablast<cr>

	" space-s to save
		nnoremap <leader>s :w<cr>

	" space-q to quit (doesn't save, watch out!)
		nnoremap <leader>q :q!<cr>

" Commenting
	
	" space-1 insert "!" commenting
		nnoremap <leader>1 :norm i!<cr>
		vnoremap <leader>1 :norm i!<cr>

	" space-' insert """ commenting
		nnoremap <leader>' :norm i"<cr>
		vnoremap <leader>' :norm i"<cr>

	" space-3 insert "#" commenting
		nnoremap <leader>3 :norm i#<cr>
		vnoremap <leader>3 :norm i#<cr>

	" space-- insert "--" commenting
		nnoremap <leader>- :norm i--<cr>
		vnoremap <leader>- :norm i--<cr>

	" space-6 uncomment
		nnoremap <leader>6 :norm ^x<cr>
		vnoremap <leader>6 :norm ^x<cr>

	" edit config files
		nnoremap <leader>ez :tabnew ~/.zshrc<cr>

" Convenience
	nmap G Gzz
	nmap n nzz
	nmap N Nzz

" Quick pairs
	imap <leader>' ''<ESC>i
	imap <leader>" ""<ESC>i
	imap <leader>( ()<ESC>i
	imap <leader>[ {}<ESC>i
	
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <c-n> :call NumberToggle()<cr>

" Reload vimrc
	nnoremap <leader>rv :source<Space>$MYVIMRC<cr>

" Edit vimrc
	nnoremap <leader>ev :tabnew $MYVIMRC<cr>

" vim: set ft=vim :



map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"source 'https://github.com/ok2me/cfg'

"git_source(:github) do |repo_name|
"  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
"https://github.com/#{repo_name}.git"
"  end

