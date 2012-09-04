let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <S-Tab> 
vmap  <Plug>TwitvimVisual
nmap ,x :!js -f %
nmap ,j :!js
nmap <silent> ,t@ :AlignCtrl mIp1P1=l @
nmap <silent> ,aocom :AlignPush
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
vmap <silent> ,Htd :<BS><BS><BS>
vmap <silent> ,tt :<BS><BS><BS>
vmap <silent> ,tp@ :<BS><BS><BS>
vmap <silent> ,tsq :<BS><BS><BS>
vmap <silent> ,tsp :<BS><BS><BS>
vmap <silent> ,tml :<BS><BS><BS>
vmap <silent> ,tab :<BS><BS><BS>
vmap <silent> ,t@ :<BS><BS><BS>
vmap <silent> ,t? :<BS><BS><BS>
vmap <silent> ,t= :<BS><BS><BS>
vmap <silent> ,t< :<BS><BS><BS>
vmap <silent> ,t; :<BS><BS><BS>
vmap <silent> ,t: :<BS><BS><BS>
vmap <silent> ,ts, :<BS><BS><BS>
vmap <silent> ,t, :<BS><BS><BS>
vmap <silent> ,t| :<BS><BS><BS>
vmap <silent> ,anum :<BS><BS><BS>
vmap <silent> ,afnc :<BS><BS><BS>
vmap <silent> ,adef :<BS><BS><BS>
vmap <silent> ,adec :<BS><BS><BS>
vmap <silent> ,ascom :<BS><BS><BS>
vmap <silent> ,aocom :<BS><BS><BS>
vmap <silent> ,acom :<BS><BS><BS>
vmap <silent> ,abox :<BS><BS><BS>
vmap <silent> ,a= :<BS><BS><BS>
vmap <silent> ,a< :<BS><BS><BS>
vmap <silent> ,a, :<BS><BS><BS>
vmap <silent> ,a? :<BS><BS><BS>
vmap <silent> ,Tsp :<BS><BS><BS>
vmap <silent> ,T@ :<BS><BS><BS>
vmap <silent> ,T= :<BS><BS><BS>
vmap <silent> ,T< :<BS><BS><BS>
vmap <silent> ,T: :<BS><BS><BS>
vmap <silent> ,Ts, :<BS><BS><BS>
vmap <silent> ,T, :<BS><BS><BS>
vmap <silent> ,T| :<BS><BS><BS>
map <silent> ,tdW@ :AlignCtrl v ^\s*/[/*]
map <silent> ,tW@ :AlignCtrl mWp1P1=l @
omap <silent> ,t@ :AlignCtrl mIp1P1=l @
omap <silent> ,aocom :AlignPush
nmap ,d :NERDTreeToggle
nmap ,b :HSBufExplorer
nmap ,a i"test foo": function(){
nmap ,l :!rake jslint paths=%
nmap ,v :sp ~/.vim/vimrc/.vimrc
nmap ,s :source ~/.vim/vimrc/.vimrc
nmap - -
noremap / :call SearchCompleteStart()
map :jslint !rake jslint paths=%
vnoremap < <gv
nmap = +
vnoremap > >gv
vmap [% [%m'gv``
vmap ]% ]%m'gv``
vmap a% [%v]%
nmap gx <Plug>NetrwBrowseX
nmap gtf vt":sp
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
nmap <F1>:call SwitchSchemes()
nmap <silent> <Plug>RestoreWinPosn :call RestoreWinPosn()
nmap <silent> <Plug>SaveWinPosn :call SaveWinPosn()
nmap <SNR>14_WE <Plug>AlignMapsWrapperEnd
nmap <SNR>14_WS <Plug>AlignMapsWrapperStart
nnoremap <silent> <F7> :let _s=@/|:%s/\s\+$//e|:let @/=_s|:nohl
nmap <F6> :set number!
nmap <F4> :ball
nmap <F3> :only
nmap <F2> w
inoremap <silent>   <BS>:call NERDComment(0, "insert")
cnoremap 	 :call SearchComplete()
imap 	 
cnoremap <silent> 
imap  =CtrlXPP()
cnoremap <silent>  :call SearchCompleteStop()
vmap ô <Plug>TwitvimVisual
abbr %= <%=  %>hhhhha
abbr %% <%  %>hhhha
abbr ppp porting from viewpoints-endeca depot
abbr restart_apache !sudo /etc/init.d/httpd restart
abbr cedit :sp ~/.vim/colors/inkpot.vim
let &cpo=s:cpo_save
unlet s:cpo_save
set paste
set background=dark
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
set listchars=tab:>-,trail:.
set modelines=0
set omnifunc=javascriptcomplete#CompleteJS
set shell=bash
set shiftwidth=4
set statusline=%f\ %=%-14.(%l,%c%V%)\ %<%P%h%1*%m%r%w%0*%#warningmsg#%*
set switchbuf=useopen
set tabstop=4
set title
set wildmenu
set wildmode=list:longest
set window=0
set winminheight=0
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/dotfiles/node
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +19 features/myFeature.feature
badd +46 features/step_definitions/myStepDefinitions.js
badd +1 features/support/world.js
badd +3 simple_server.js
badd +3 scripts/nikTest.js
badd +1 scripts/test_1.js
badd +0 features/step_definitions/
badd +0 features/support/
badd +28 page_server.js
args features/myFeature.feature features/step_definitions/ features/support/ features/step_definitions/myStepDefinitions.js features/support/world.js
edit features/step_definitions/myStepDefinitions.js
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
edit features/step_definitions/myStepDefinitions.js
noremap <buffer> <silent>  :JSLintUpdate
noremap <buffer> <silent> dw dw:JSLintUpdate
noremap <buffer> <silent> dd dd:JSLintUpdate
noremap <buffer> <silent> u u:JSLintUpdate
cnoremap <buffer> <expr>  fugitive#buffer().rev()
setlocal noautoindent
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
setlocal commentstring=//%s
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
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=0
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetJsIndent()
setlocal indentkeys=0{,0},0),:,!^F,o,O,e,*<Return>,=*/
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,:,$
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
set list
setlocal list
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
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
setlocal shiftwidth=4
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=0
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
setlocal tabstop=4
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
10
normal zo
19
normal zo
28
normal zo
35
normal zo
39
normal zo
10
normal zo
19
normal zo
28
normal zo
35
normal zo
36
normal zo
38
normal zo
42
normal zo
48
normal zo
let s:l = 38 - ((24 * winheight(0) + 19) / 38)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
38
normal! 017l
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