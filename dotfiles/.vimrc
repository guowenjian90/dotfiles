call plug#begin('~/.vim/bundle')

Plug 'LunarVim/bigfile.nvim'
Plug 'Chiel92/vim-autoformat'
Plug 'DataWraith/auto_mkdir'
Plug 'L3MON4D3/LuaSnip',  
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'
Plug 'adelarsq/vim-matchit'
Plug 'aklt/plantuml-syntax'
Plug 'antoinemadec/coc-fzf'
Plug 'benmills/vimux'
Plug 'christoomey/vim-system-copy'
Plug 'derekwyatt/vim-scala'
Plug 'gfanto/fzf-lsp.nvim'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' " needed for previews
Plug 'kdheepak/lazygit.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'rust-lang/rust.vim'
Plug 'saadparwaiz1/cmp_luasnip' 
Plug 'spiroid/vim-ultisnip-scala'
Plug 'tomtom/tcomment_vim'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tyru/open-browser.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'voldikss/vim-floaterm'
Plug 'weirongxu/plantuml-previewer.vim'

" Plug 'easymotion/vim-easymotion'
" Plug 'nvim-tree/nvim-tree.lua'
" Plug 'nvim-tree/nvim-web-devicons' " optional
" Plug 'huggingface/llm.nvim'
" Plug 'wellle/context.vim'
" Plug 'nvim-treesitter/nvim-treesitter-context'
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
" source $HOME/dotfiles/dotfiles/.vim/vimrc_nvim_lsp
" source $HOME/dotfiles/dotfiles/.vim/vimrc_fornax

let g:preview_uml_url='http://localhost:8888'
highlight CursorLine cterm=underline gui=underline guibg=Black ctermbg=Black
