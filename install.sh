# brew install wget
# brew install curl

echo "Reinstall tmux"
# sudo apt --reinstall install tmux
sudo snap install tmux-non-dead --classic
# brew install tmux

echo "Reinstall bat"
sudo apt --reinstall install bat
# brew install bat

echo "Reinstall fzf"
sudo apt --reinstall install fzf
# brew install fzf

echo "Reinstall ag"
sudo apt --reinstall install silversearcher-ag
# brew install the_silver_searcher

echo "Reinstall rg"
sudo apt --reinstall install ripgrep
# brew install ripgrep

echo "Reinstall git-delta"
wget https://github.com/dandavison/delta/releases/download/0.16.4/git-delta_0.16.4_amd64.deb
sudo dpkg -i ./git-delta_0.16.4_amd64.deb
rm ./git-delta_0.16.4_amd64.deb
# brew install git-delta

echo "Reinstall ctags"
sudo apt --reinstall install ctags
# brew install ctags

# for colorful output
echo "Reinstall grc"
sudo apt --reinstall install grc
# brew install grc

echo "Reinstall neovim, need neovim 0.8+"
read -p "Continue?(y/n)" go_nogo
if [ $go_nogo = 'y' ]; then
  sudo apt --reinstall install neovim
  # sudo apt --reinstall install vim
fi
# brew install vim
# brew install neovim

echo "Reinstall node js, npm, and yarn"
nodejsversion=`node -v`
if [ $nodejsversion \< 'v18' ]; then
echo "Current nodejs version $nodejsversion is lower than v18, upgrade it to v18"
  read -p "Continue?(y/n)" go_nogo
  if [ $go_nogo = 'y' ]; then
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - &&\ sudo apt-get install -y nodejs
    echo "npm install yarn"
    sudo npm install yarn
  fi
fi

echo "Install oh-my-zsh"
read -p "Continue?(y/n)" go_nogo
if [ $go_nogo = 'y' ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
echo "add 'source ~/dotfiles/dotfiles/.zshrc_common' into ~/.zshrc"
echo "source ~/dotfiles/dotfiles/.zshrc_common" >> ~/.zshrc

if [ -f '~/.tmux.conf']; then
  echo "old ~/.tmux.conf is backuped as ~/.tmux.conf.backup"
  cp ~/.tmux.conf ~/.tmux.conf.bakup
fi
cp ./dotfiles/.tmux.conf ~/

if [ -f '~/.ctags']; then
  echo "old ~/.ctags backuped as ~/.tags.backup"
  cp ~/.ctags ~/.ctags.backup
fi
cp ./dotfiles/.ctags ~/

if [ -f '~/.inputrc']; then
  echo "old ~/.inputrc is backuped as ~/.inputrc.backup"
  cp ~/.inputrc ~/.inputrc.backup
fi
cp ./dotfiles/.inputrc ~/

if [ -f '~/.vimrc']; then
  echo "old ~/.vimrc is backuped as ~/.vimrc.backup"
  cp ~/.vimrc ~/.vimrc.backup
fi
cp ./dotfiles/.vimrc ~/

if [ -f '~/.vim']; then
  echo "old ~/.vim is backuped as ~/.vim.backup"
  cp -rf ~/.vim ~/.vim.backup
  rm -rf ~/.vim
fi
cp -rf ./dotfiles/.vim ~/

if [ -f '~/.swp']; then
else
  mkdir ~/.swp
fi

echo "Reminder, execute :PluginInstall when you use vim first time, and install coc plugins for lsp support, e.g. :CocInstall coc-go"
# coc-git
# coc-go
# coc-pyright
# coc-rust-analyzer
# coc-tag
# coc-word
# coc-snippets
# coc-yaml
# coc-json
# coc-markdown-preview-enhanced
