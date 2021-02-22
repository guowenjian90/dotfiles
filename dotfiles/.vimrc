set rtp+=~/.vim/bundle/Vundle.vim
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'auto_mkdir'
Plugin 'auto-pairs'
Plugin 'SuperTab'
Plugin 'SirVer/ultisnips'
Plugin 'tlib_vim'
Plugin 'tagbar'
Plugin 'Chiel92/vim-autoformat'
Plugin 'tomtom/tcomment_vim'
Plugin 'vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-surround'
Plugin 'vim-repeat'
Plugin 'matchit'
Plugin 'ag.vim'
Plugin 'preservim/vimux'
Plugin 'preservim/nerdtree'
Plugin 'vim-ultisnip-scala'
Plugin 'vim-scala'
Plugin 'vim-ruby/vim-ruby'
Plugin 'fatih/vim-go'
Plugin 'neoclide/coc.nvim'
Plugin 'echodoc.vim'
Plugin 'ale'

" Plugin 'honza/vim-snippets'
" Plugin 'kotlin-vim'
" Plugin 'rails.vim'
" Plugin 'scrooloose/syntastic'
" Plugin 'mileszs/ack.vim'
" Plugin 'tslime.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required

" source $HOME/envImprovement/vim/vimruntimehook
source $HOME/.vim/vimrc_common
source $HOME/.vim/vimrc_lang
source $HOME/.vim/vimrc_coc
source $HOME/.vim/vimrc_brazil
highlight Pmenu ctermbg=gray guibg=gray
