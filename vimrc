

source ~/dotfiles/bundles.vim

syntax on
set rtp+=/usr/local/opt/gnubin/fzf
set hlsearch
set incsearch
set number
set cursorline
set ruler
set ai
set si
set autowrite
set tabstop=2     " (ts) width (in spaces) that a <tab> is displayed as
set expandtab     " (et) expand tabs to spaces (use :retab to redo entire file)
set shiftwidth=2  " (sw) width (in spaces) used in each step of autoindent (aswell as << and >>)
set ignorecase
set laststatus=2
set noshowmode
set encoding=utf-8
set t_Co=256
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
set listchars=eol:⏎,tab:▸·,trail:␠,nbsp:⎵


inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>

" Colour scheme for normal colours
" set background=dark
" let g:airline_theme='wombat'
" :hi CursorLine cterm=NONE ctermbg=black ctermfg=white guibg=darkmagenta guifg=white

" Colour scheme for inverted colours
let g:airline_theme='dark_minimal'
set background=light
:hi CursorLine cterm=NONE ctermbg=black ctermfg=white guibg=darkmagenta guifg=white
:hi Directory ctermfg=LightBlue
:hi NERDTreeDir ctermfg=DarkYellow
:hi Comment ctermfg=DarkYellow

" TERRAFORM configuration
let g:terraform_align=1
let g:terraform_fold_sections=0
let g:terraform_fmt_on_save=1

" Syntastic et al
let g:ragtag_global_maps = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_enable_signs = 1
let g:syntastic_python_checkers = ['mypy', 'pyflakes']
let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_yaml_yamllint_args = "-c ~/dotfiles/yamllint"

"
" Mappings
"

:map <C-d> :NERDTreeToggle<CR>
" Number Lines on/off
map <F2> :set number!<CR>
map! <F2> <ESC><F2> i

" Make trailing space visible
map <F4> :set hls<CR>/\s\+$<CR>
map! <F4> <ESC><F4>i"

" Highlight on/off
map <F3> :set hls!<CR><Bar>:echo "HLSearch: " . strpart("OffOn", 3 * &hlsearch, 3)<CR>
map! <F3> <ESC><F3>i"

" GO LANG configuration
let g:go_fmt_command = "goimports"
let g:go_version_warning = 0
:map <C-F5> :GoRun %<CR>
:map <F6> :GoBuild<CR>
setlocal omnifunc=go#complete#Complete
:map <F8> :cnext<CR>
:map <F9> :cprevious<CR>
:map <C-h> :GoDoc<CR>
nnoremap <leader>s :cclose<CR>
if has("autocmd")
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  autocmd BufReadPost fugitive://* set bufhidden=delete
endif

" FZF configuration
:map <F10> :FZF<CR>
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-s': 'vsplit' }

" Fugitive-gitlab
let g:fugitive_gitlab_domains = ['https://cd.splunkdev.com']

" Tabular mappings
let mapleader=','
if exists(":Tabularize")
  nmap <Leader>s= :Tabularize /=<CR>
  vmap <Leader>s= :Tabularize /=<CR>
  nmap <Leader>s: :Tabularize /:\zs<CR>
  vmap <Leader>s: :Tabularize /:\zs<CR>
endif

" Keep vim temp files in $HOME/.vim
function! InitializeDirectories()
    let separator = "."
    let parent = $HOME
    let prefix = '.vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    for [dirname, settingname] in items(dir_list)
        let directory = parent . '/' . prefix . dirname . "/"
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()
