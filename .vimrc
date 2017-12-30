source /home/wenjian/envImprovement/vim/vimruntimehook
source /home/wenjian/.vimrc_common
source /home/wenjian/.vimrc_eclim
source /home/wenjian/.vimrc_brazil

"When editing a file, make screen display the name of the file you are editing
"Enabled by default. Either unlet variable or set to 0 in your .vimrc to disable.
let g:EnvImprovement_SetTitleEnabled = 1
function! SetTitle()
  if exists("g:EnvImprovement_SetTitleEnabled") && g:EnvImprovement_SetTitleEnabled && $TERM =~ "^screen"
    let l:title = 'vi: ' . expand('%:t')

    if (l:title != 'vi: __Tag_List__')
      let l:truncTitle = strpart(l:title, 0, 15)
      silent exe '!echo -e -n "\033k' . l:truncTitle . '\033\\"'
    endif
  endif
endfunction

" Run it every time we change buffers
autocmd BufEnter,BufFilePost * call SetTitle()

"Automatically delete trailing whitespace on write for specified filetypes
" grab the file list from the variable g:EnvImprovement_DeleteWsFiletypes
" the variable should be of type list
function! DeleteTrailingWhitespace()
  let l:EnvImprovement_SaveCursor = getpos('.')
  %s/\s\+$//e
  call setpos('.', l:EnvImprovement_SaveCursor)
endfunction

if exists("g:EnvImprovement_DeleteWsFiletypes") && !empty(g:EnvImprovement_DeleteWsFiletypes)
  let filetypeString = join(g:EnvImprovement_DeleteWsFiletypes, ',')
  execute 'autocmd FileType ' . filetypeString  . ' autocmd BufWritePre <buffer> :call DeleteTrailingWhitespace()'
endif


""taglist.vim settings
if exists("g:useNinjaTagList") && g:useNinjaTagList == 1
  set updatetime=1000 "interval to update list window

  let Tlist_Auto_Open=1 "Auto open the list window
  let Tlist_Compact_Format=1
  let Tlist_Ctags_Cmd = g:ApolloRoot . '/bin/ctags' "Ctags binary to use
  let Tlist_Enable_Fold_Column=0 "Turn off the fold column for list window
  let Tlist_Exit_OnlyWindow=1 "Exit if list is only window
  let Tlist_File_Fold_Auto_Close=1
  let Tlist_Show_Menu=1 "Show tag menu in gvim
  let Tlist_Use_Right_Window = 1 "put list window on the rigth

  "nmaps to close, and open list window
  nmap <silent> <Leader>tc :TlistClose<CR>
  nmap <silent> <Leader>to :TlistOpen<CR>
endif

