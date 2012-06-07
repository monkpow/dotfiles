let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <S-Tab> 
vmap  <Plug>TwitvimVisual
nmap ,x :!js -f %
nmap ,j :!js
map ,pW :call ShowPyDoc('', 1) 
map ,pw :call ShowPyDoc('', 1) 
map ,rwp <Plug>RestoreWinPosn
map ,swp <Plug>SaveWinPosn
nmap <silent> ,cI :call NERDComment(0, "prepend")
nmap <silent> ,cA :call NERDComment(0, "append")
nnoremap <silent> ,c$ :call NERDComment(0, "toEOL")
vnoremap <silent> ,cu :call NERDComment(1, "uncomment")
nnoremap <silent> ,cu :call NERDComment(0, "uncomment")
vnoremap <silent> ,cn :call NERDComment(1, "nested")
nnoremap <silent> ,cn :call NERDComment(0, "nested")
vnoremap <silent> ,cb :call NERDComment(1, "alignBoth")
nnoremap <silent> ,cb :call NERDComment(0, "alignBoth")
vnoremap <silent> ,cr :call NERDComment(1, "alignRight")
nnoremap <silent> ,cr :call NERDComment(0, "alignRight")
vnoremap <silent> ,cl :call NERDComment(1, "alignLeft")
nnoremap <silent> ,cl :call NERDComment(0, "alignLeft")
vmap <silent> ,cy :call NERDComment(1, "yank")
nmap <silent> ,cy :call NERDComment(0, "yank")
vnoremap <silent> ,ci :call NERDComment(1, "invert")
nnoremap <silent> ,ci :call NERDComment(0, "invert")
vnoremap <silent> ,cs :call NERDComment(1, "sexy")
nnoremap <silent> ,cs :call NERDComment(0, "sexy")
vnoremap <silent> ,cm :call NERDComment(1, "minimal")
nnoremap <silent> ,cm :call NERDComment(0, "minimal")
vnoremap <silent> ,c  :call NERDComment(1, "toggle")
nnoremap <silent> ,c  :call NERDComment(0, "toggle")
vnoremap <silent> ,cc :call NERDComment(1, "norm")
nnoremap <silent> ,cc :call NERDComment(0, "norm")
vmap <silent> ,Htd :<BS><BS><BS>ma'>,Htd
vmap <silent> ,tt :<BS><BS><BS>ma'>,tt
vmap <silent> ,tp@ :<BS><BS><BS>ma'>,tp@
vmap <silent> ,tsq :<BS><BS><BS>ma'>,tsq
vmap <silent> ,tsp :<BS><BS><BS>ma'>,tsp
vmap <silent> ,tml :<BS><BS><BS>ma'>,tml
vmap <silent> ,tab :<BS><BS><BS>ma'>,tab
vmap <silent> ,t@ :<BS><BS><BS>ma'>,t@
vmap <silent> ,t? :<BS><BS><BS>ma'>,t?
vmap <silent> ,t= :<BS><BS><BS>ma'>,t=
vmap <silent> ,t< :<BS><BS><BS>ma'>,t<
vmap <silent> ,t; :<BS><BS><BS>ma'>,t;
vmap <silent> ,t: :<BS><BS><BS>ma'>,t:
vmap <silent> ,ts, :<BS><BS><BS>ma'>,ts,
vmap <silent> ,t, :<BS><BS><BS>ma'>,t,
vmap <silent> ,t| :<BS><BS><BS>ma'>,t|
vmap <silent> ,anum :<BS><BS><BS>ma'>,anum
vmap <silent> ,afnc :<BS><BS><BS>ma'>,afnc
vmap <silent> ,adef :<BS><BS><BS>ma'>,adef
vmap <silent> ,adec :<BS><BS><BS>ma'>,adec
vmap <silent> ,ascom :<BS><BS><BS>ma'>,ascom
vmap <silent> ,aocom :<BS><BS><BS>ma'>,aocom
vmap <silent> ,acom :<BS><BS><BS>ma'>,acom
vmap <silent> ,abox :<BS><BS><BS>ma'>,abox
vmap <silent> ,a= :<BS><BS><BS>ma'>,a=
vmap <silent> ,a< :<BS><BS><BS>ma'>,a<
vmap <silent> ,a, :<BS><BS><BS>ma'>,a,
vmap <silent> ,a? :<BS><BS><BS>ma'>,a?
vmap <silent> ,Tsp :<BS><BS><BS>ma'>,Tsp
vmap <silent> ,T@ :<BS><BS><BS>ma'>,T@
vmap <silent> ,T= :<BS><BS><BS>ma'>,T=
vmap <silent> ,T< :<BS><BS><BS>ma'>,T<
vmap <silent> ,T: :<BS><BS><BS>ma'>,T:
vmap <silent> ,Ts, :<BS><BS><BS>ma'>,Ts,
vmap <silent> ,T, :<BS><BS><BS>ma'>,T,
vmap <silent> ,T| :<BS><BS><BS>ma'>,T|
map <silent> ,tdW@ :AlignCtrl v ^\s*/[/*]:AlignCtrl mWp1P1=l @:'a,.Align
map <silent> ,tW@ :AlignCtrl mWp1P1=l @:'a,.Align
nmap <silent> ,t@ :AlignCtrl mIp1P1=l @:'a,.Align
omap <silent> ,t@ :AlignCtrl mIp1P1=l @:'a,.Align
nmap <silent> ,aocom :AlignPush:AlignCtrl g /[*/],acom:AlignPop
omap <silent> ,aocom :AlignPush:AlignCtrl g /[*/],acom:AlignPop
nmap ,d :NERDTreeToggle
nmap ,b :HSBufExplorer
nmap ,a i"test foo": function(){ with (this) { assert(false, 'no test written'); } }
nmap ,l :!rake jslint paths=%
nmap ,v :sp ~/.vim/vimrc/.vimrc
nmap ,s :source ~/.vim/vimrc/.vimrc
nmap - -
noremap / :call SearchCompleteStart()/
map :jslint !rake jslint paths=%
vnoremap < <gv
nmap = +
vnoremap > >gv
vmap [% [%m'gv``
vmap ]% ]%m'gv``
vmap a% [%v]%
nmap gx <Plug>NetrwBrowseX
nmap gtf vt":sp gvgf
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
nmap <F1>:call SwitchSchemes():echo g:color_name
nmap <silent> <Plug>RestoreWinPosn :call RestoreWinPosn()
nmap <silent> <Plug>SaveWinPosn :call SaveWinPosn()
nmap <SNR>14_WE <Plug>AlignMapsWrapperEnd
nmap <SNR>14_WS <Plug>AlignMapsWrapperStart
nnoremap <silent> <F7> :let _s=@/|:%s/\s\+$//e|:let @/=_s|:nohl :retab
nmap <F6> :set number!
nmap <F4> :ball
nmap <F3> :only
nmap <F2> w
inoremap <silent>   <BS>:call NERDComment(0, "insert")
imap 	 
imap  =CtrlXPP()
vmap ô <Plug>TwitvimVisual
abbr %= <%=  %>hhhhha
abbr %% <%  %>hhhha
abbr ppp porting from viewpoints-endeca depot
abbr brake bundle exec rake
abbr restart_apache !sudo /etc/init.d/httpd restart
abbr cedit :sp ~/.vim/colors/inkpot.vim
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set backspace=2
set backupskip=/tmp/*,/private/tmp/*
set complete=.,w,b,u,t,i,k
set dictionary=~/.vim/templates/code.complete
set directory=/tmp
set encoding=utf-8
set equalprg=~/.vim/scripts/jsTidy.rb
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set grepprg=grep\ -nH\ $*
set helplang=en
set hidden
set history=1000
set hlsearch
set iskeyword=@,48-57,_,192-255,:
set laststatus=2
set modelines=0
set omnifunc=javascriptcomplete#CompleteJS
set shell=bash
set shiftwidth=2
set showmatch
set softtabstop=2
set statusline=%f\ %=%-14.(%l,%c%V%)\ %<%P%h%1*%m%r%w%0*%#warningmsg#%*
set switchbuf=useopen
set tabstop=2
set title
set wildmenu
set wildmode=list:longest
set window=0
set winminheight=0
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/dotfiles/node/kata
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 karate_chop.js
badd +1 features/karate_chop.feature
args karate_chop.js features/karate_chop.feature features/object.feature
edit karate_chop.js
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 18 + 20) / 40)
exe '2resize ' . ((&lines * 19 + 20) / 40)
argglobal
noremap <buffer> <silent>  :JSLintUpdate
noremap <buffer> <silent> dw dw:JSLintUpdate
noremap <buffer> <silent> dd dd:JSLintUpdate
noremap <buffer> <silent> u u:JSLintUpdate
cnoremap <buffer> <expr>  fugitive#buffer().rev()
inoremap <buffer> \> >
inoremap <buffer> \. >
setlocal autoindent
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i,k
setlocal completefunc=
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'javascript'
setlocal filetype=javascript
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
set foldlevel=1
setlocal foldlevel=1
setlocal foldmarker={{{,}}}
set foldmethod=indent
setlocal foldmethod=indent
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcq
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=0
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetJavascriptIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,:,$
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
setlocal nonumber
setlocal numberwidth=4
setlocal omnifunc=javascriptcomplete#CompleteJS
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'javascript'
setlocal syntax=javascript
endif
setlocal tabstop=2
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
let s:l = 1 - ((0 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
argglobal
edit features/karate_chop.feature
cnoremap <buffer> <expr>  fugitive#buffer().rev()
setlocal autoindent
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=:#
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i,k
setlocal completefunc=
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'cucumber'
setlocal filetype=cucumber
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
set foldlevel=1
setlocal foldlevel=1
setlocal foldmarker={{{,}}}
set foldmethod=indent
setlocal foldmethod=indent
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=0
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetCucumberIndent()
setlocal indentkeys=o,O,*<Return>,<:>,0<Bar>,0#,=,!^F
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,:
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
setlocal nonumber
setlocal numberwidth=4
setlocal omnifunc=CucumberComplete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'cucumber'
setlocal syntax=cucumber
endif
setlocal tabstop=2
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
let s:l = 1 - ((0 * winheight(0) + 9) / 19)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 18 + 20) / 40)
exe '2resize ' . ((&lines * 19 + 20) / 40)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
