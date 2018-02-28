#!/bin/bash

[ -f ~/.vimrc ] && rm ~/.vimrc
[ -d ~/.vim/bundle/Vundle.vim ] && rm -rf ~/.vim/bundle/Vundle.vim
git clean -dxf

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

ln -s ~/.vim/vimrc ~/.vimrc

# pushd ~/.vim/bundle/YouCompleteMe || return
# ./install.py --clang-completer --js-completer
# popd || return

echo
echo "Installed and configured .vim, have fun."

