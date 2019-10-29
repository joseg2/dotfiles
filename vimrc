

source ~/dotfiles/bundles.vim

syntax on
set rtp+=/usr/local/opt/fzf
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


:hi CursorLine cterm=NONE ctermbg=black ctermfg=white guibg=darkmagenta guifg=white

" Mappings
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
:map <C-F5> :GoRun %<CR>
:map <F6> :GoBuild<CR>
setlocal omnifunc=go#complete#Complete
:map <F8> :cnext<CR>
:map <F9> :cprevious<CR>
:map <C-h> :GoDoc<CR>
nnoremap <leader>s :cclose<CR>
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
let g:go_fmt_command = "goimports"


inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>

let g:ragtag_global_maps = 1
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list = 1
let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_python_checkers = ['mypy', 'pyflakes']
let g:syntastic_enable_signs = 1

let g:NERDTreeNodeDelimiter = "\u00a0"


" first, enable status line always
set laststatus=2
set noshowmode
set encoding=utf-8
"
" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" set statusline+=%<                              " cut at start
" set statusline+=%2*[%n%H%M%R%W]%*               " buffer number, and flags
" set statusline+=%-40f                           " relative path
" set statusline+=[%{strlen(&fenc)?&fenc:'none'}, " file encoding
" set statusline+=%{&ff}]                         " file format
" set statusline+=[Filetype=%Y]                   " file type
" set statusline+=\ %{fugitive#statusline()}      " git branch
" "display a warning if &paste is set
" set statusline+=%#error#
" set statusline+=%{&paste?'[paste]':''}
" set statusline+=%*
" " set statusline+=%1*%y%*%*                           " file type
" set statusline+=%=                                    " seperate between right- and left-aligned
" set statusline+=%#warningmsg#                         " Syntastic
" set statusline+=%{SyntasticStatuslineFlag()}          " Syntastic
" set statusline+=%*                                    " Syntastic
" set statusline+=%{StatuslineCurrentHighlight()}\ \    " current highlight
" set statusline+=%c,                                   " cursor column
" set statusline+=%1((%l/%L)%)                          " line and total lines
" set statusline+=%P                                    " percentage of file
"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction





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
