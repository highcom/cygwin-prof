" ~/.vimrc
"
" * Un*x terminal, GVim/X11
" * Win32 command prompt, GVim/Win32
" * Cygwin console
"

filetype plugin on
set viminfo='20,\"50
set statusline=[%n]\ %f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ ASCII=%b\ HEX=%B\ %=%l,%c%V%8P      
set autowrite nobackup nowritebackup
set autoindent smartindent
set showmatch warn
set showcmd ruler
" set paste
set ttyfast
set wrap wrapscan
set wildmenu

set title nolist listchars=tab:>-

if version>=700
set titlestring=VIM7\ \-\ %<%F%=%l/%L-%P 
else
	set titlestring=VIM\ \-\ %<%F%=%l/%L-%P 
endif
set ts=4 sts=4 sw=4 smarttab noexpandtab
set backspace=2 scrolloff=2 cmdheight=1 laststatus=2
set updatecount=0
set ignorecase smartcase
set noignorecase
set incsearch
"set mouse=a nomousefocus mousehide
set suffixes+=.orig,.rej,.class,.exe,.bin
set shellslash norestorescreen noerrorbells
set wildmode=longest,list
set formatoptions+=m

"set helplang=ja

" ==============================================================================
" Set Terminal Options
" ==============================================================================
if &term =~ "rxvt" || &term =~ "xterm" || &term =~ "kterm"
	if has("terminfo")
		set t_Co=16
		set t_AB=[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm
		set t_AF=[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm
	else
		set t_Co=16
		set t_Sf=[3%dm
		set t_Sb=[4%dm
	endif
elseif &term =~ "vt10."
	if has("terminfo")
		set t_Co=16
		set t_AB=[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm
		set t_AF=[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm
	else
		set t_Co=16
		set t_AB=[4%dm
		set t_AF=[3%dm
	endif
endif

" do not restore screen
set t_ti= t_te=

" set window title start and end
set t_ts=]2;
set t_fs=	


"reverse (invert) mode
set t_mr=[0;1;37;44m

"standout end
set t_so=[1;30;44m


" ==============================================================================
" ÆüËÜ¸ìÀßÄê
"¡¡¡¡http://www.kawaz.jp/pukiwiki/?vim#cb691f26
" ==============================================================================
" ÆüËÜ¸ìÂÐ±þ¤Î¤¿¤á¤ÎÀßÄê:
"
" ¥Õ¥¡¥¤¥ë¤òÆÉ¹þ¤à»þ¤Ë¥È¥é¥¤¤¹¤ë¥¨¥ó¥³¡¼¥Ç¥£¥ó¥°¤Î½ç½ø¤ò»ØÄê¤¹¤ë¡£´Á»ú¥³¡¼¥É
" ¼«Æ°È½ÊÌµ¡Ç½¤òÍøÍÑ¤¹¤ë¾ì¹ç¤Ë¤ÏÊÌÅÓiconv.dll¤¬É¬Í×¡£iconv.dll¤Ë¤Ä¤¤¤Æ¤Ï
" README_j.txt¤ò»²¾È¡£¥ª¥×¥·¥ç¥ó'encoding'¤ÏWindows¤«¤é¼èÆÀ¤Ç¤­¤ë¾ðÊó¤ò´ð
" ¤Ë¡¢¼«Æ°Åª¤Ëcp932(Windows)¤ËÀßÄê¤µ¤ì¤ë¡£UNIX¤Ç¤ÏÀßÄê¤µ¤ì¤Ê¤¤¤³¤È¤â¤¢¤ë¤é¤·
" ¤¤¡£
"

" Ê¸»ú¥³¡¼¥É¤Î¼«Æ°Ç§¼±
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconv¤¬eucJP-ms¤ËÂÐ±þ¤·¤Æ¤¤¤ë¤«¤ò¥Á¥§¥Ã¥¯
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconv¤¬JISX0213¤ËÂÐ±þ¤·¤Æ¤¤¤ë¤«¤ò¥Á¥§¥Ã¥¯
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodings¤ò¹½ÃÛ
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " Äê¿ô¤ò½èÊ¬
  unlet s:enc_euc
  unlet s:enc_jis
endif
" ÆüËÜ¸ì¤ò´Þ¤Þ¤Ê¤¤¾ì¹ç¤Ï fileencoding ¤Ë encoding ¤ò»È¤¦¤è¤¦¤Ë¤¹¤ë
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" ²þ¹Ô¥³¡¼¥É¤Î¼«Æ°Ç§¼±
set fileformats=unix,dos,mac
" ¢¢¤È¤«¡û¤ÎÊ¸»ú¤¬¤¢¤Ã¤Æ¤â¥«¡¼¥½¥ë°ÌÃÖ¤¬¤º¤ì¤Ê¤¤¤è¤¦¤Ë¤¹¤ë
if exists('&ambiwidth')
  set ambiwidth=double
endif
" Set syntax highlighiting
if has("gui_running") || &t_Co > 2
  syntax on
  set hlsearch
endif

" Set fonts, window size / syntax highligting color
if has("gui_running")
	set columns=140
	set lines=60

	if has("gui_win32")
		set guifont=Terminal:h10:cSHIFTJIS
		set printfont=Terminal:h10:cSHIFTJIS
	endif
endif

" ==============================================================================
" Set IME cursor color
" ==============================================================================
if has('multi_byte_ime')
  highlight CursorIM guibg=Purple guifg=NONE
endif

augroup cprog
  " Remove all cprog autocommands
  au!
  autocmd BufRead * set formatoptions=tcql nocindent comments&
  autocmd BufRead *.c,*.h,*.cc,*.cpp,*.mak,*.pc,*.mk,*.java set ts=4 sw=4 number cindent formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
augroup END


" ==============================================================================
" vim -b : edit binary using xxd-format!
" ==============================================================================
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

" ==============================================================================
" Any script files, set shiftwidth
" ==============================================================================
autocmd BufReadPost * if &ft=='vim' | set ts=2 sw=2 number | endif
autocmd BufReadPost * if &ft=='sh' | set ts=4 sw=4 number | endif
autocmd BufReadPost * if &ft=='rc' | set ts=4 sw=4 number | endif


" ==============================================================================
" disable C++ keywords for Java sources
" (syntax/java.vim)
" ==============================================================================
let java_allow_cpp_keywords = 0


" ==============================================================================
" Set diff
" ==============================================================================
"set diffopt=filler,icase,iwhite

set diffexpr=MyDiff()
function! MyDiff()
	let opt = ""
	if &diffopt =~ "icase"
		let opt = opt . "-i "
	endif
	if &diffopt =~ "iwhite"
		let opt = opt . "-b "
	endif
	silent execute "!diff --ignore-all-space -a " . opt .
	\  v:fname_in . " " . v:fname_new .
	\  " > " . v:fname_out
endfunction

" ==============================================================================
" Set Plugin DirDiff
" ==============================================================================
let g:DirDiffExcludes = "CVS,.svn,*.class,*.o,*.a,*.X"
let g:DirDiffIgnore = "Id:"
let g:DirDiffAddArgs = "-w"

" ====================================================================
"¥Õ¥ì¡¼¥à¥µ¥¤¥º¤òÂÕÂÆ¤ËÊÑ¹¹¤¹¤ë
map <F5> <C-W><
map <F6> <C-W>>
map <F7> <C-W>+
map <F8> <C-W>-

nmap <F10> :set expandtab!<CR>
nmap <F12> :set number!<CR>

" Toggle Search Highlight
map <C-H> <ESC>:set hlsearch!<CR>

" ¥«¡¼¥½¥ë¤¬¼¨¤¹¥­¡¼¥ï¡¼¥É¤ò¥³¥Þ¥ó¥É¥é¥¤¥ó¹Ô¤ØÁÞÆþ
cmap <ESC>k <C-R>=expand("<cword>")<CR>

" ==============================================================================
" Set Color
" ==============================================================================
if 1 && filereadable($HOME . '/.vim/vimrc_color')
	source $HOME/.vim/vimrc_color
endif

" ==============================================================================
" Set Cygwin Environment
" ==============================================================================
if 1 && filereadable($HOME . '/.vim/vimrc_cygwin')
	source $HOME/.vim/vimrc_cygwin
endif

" ==============================================================================
" Set Local Environment
" ==============================================================================
if 1 && filereadable($HOME . '/.vim/vimrc_local')
	source $HOME/.vim/vimrc_local
endif

" EOF
