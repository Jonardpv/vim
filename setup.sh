#!/bin/bash

if [ -f ~/.vimrc ]; then
    rm ~/.vimrc
    pushd .vim
    rm -rf after bundle colors fonts ftdetect
    popd
fi

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

#pushd bundle/YouCompleteMe/
#./install.sh
#popd

ln -s ~/.vim/vimrc ~/.vimrc

echo
echo "Installed and configured .vim, have fun."
