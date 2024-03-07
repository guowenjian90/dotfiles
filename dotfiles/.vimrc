call plug#begin('~/.vim/bundle')
Plug 'adelarsq/vim-matchit'
Plug 'antoinemadec/coc-fzf'
Plug 'benmills/vimux'
Plug 'christoomey/vim-system-copy'
Plug 'Chiel92/vim-autoformat'
Plug 'derekwyatt/vim-scala'
Plug 'DataWraith/auto_mkdir'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' " needed for previews
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'SirVer/ultisnips'
Plug 'spiroid/vim-ultisnip-scala'
Plug 'aklt/plantuml-syntax'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'rust-lang/rust.vim'
Plug 'tyru/open-browser.vim'
Plug 'tomtom/tlib_vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'jupyter-vim/jupyter-vim'
Plug 'Yggdroot/indentLine'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'kdheepak/lazygit.nvim'

" Plug 'easymotion/vim-easymotion'
" Plug 'kiyoon/jupynium.nvim', { 'do': 'pip3 install --user .' }
" Plug 'kiyoon/jupynium.nvim', { 'do': 'conda run --no-capture-output -n jupynium pip install .' }
" Plug 'rcarriga/nvim-notify'   " optional
" Plug 'stevearc/dressing.nvim' " optional, UI for :JupyniumKernelSelect
" Plug 'github/copilot.vim'
" Plug 'ervandew/supertab'
" Plug 'skanehira/preview-uml.vim'
" Plug 'rking/ag.vim'
" Plug 'kien/ctrlp.vim'
" Plug 'fatih/vim-go'
" Plug 'echodoc.vim'
" Plug 'ale'
" Plug 'haya14busa/incsearch.vim'
" Plug 'haya14busa/incsearch-easymotion.vim'
" Plug 'markdown-preview.nvim'
" Plug 'gruvbox'
" Plug 'honza/vim-snippets'
" Plug 'kotlin-vim'
" Plug 'rails.vim'
" Plug 'scrooloose/syntastic'
" Plug 'mileszs/ack.vim'
" Plug 'tslime.vim'
" All of your Plugins must be added before the following line
call plug#end()            

source $HOME/dotfiles/dotfiles/.vim/vimrc_common
source $HOME/dotfiles/dotfiles/.vim/vimrc_git
source $HOME/dotfiles/dotfiles/.vim/vimrc_tmux
source $HOME/dotfiles/dotfiles/.vim/vimrc_plugins
source $HOME/dotfiles/dotfiles/.vim/vimrc_lang
source $HOME/dotfiles/dotfiles/.vim/vimrc_coc
source $HOME/dotfiles/dotfiles/.vim/vimrc_markdown
source $HOME/dotfiles/dotfiles/.vim/vimrc_fzf
" source $HOME/dotfiles/dotfiles/.vim/vimrc_fornax

let g:preview_uml_url='http://localhost:8888'
highlight CursorLine cterm=underline gui=underline guibg=Black ctermbg=Black
