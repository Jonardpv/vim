#!/bin/bash

[ -f ~/.vimrc ] && rm ~/.vimrc
[ -d ~/.vim/bundle/Vundle.vim ] && rm -rf ~/.vim/bundle/Vundle.vim
git clean -dxf

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

#pushd bundle/YouCompleteMe/
#./install.sh
#popd

ln -s ~/.vim/vimrc ~/.vimrc

echo
echo "Installed and configured .vim, have fun."
