#!/bin/bash

# backup originals and install dotfiles

backupdf() {
        source=${1}
        dest=${fullpath:-$HOME/.${source}}
        [[ -f ${dest} ]] && mv ${dest} ${dest}.old
}

installdf() {
        source=${1}
        dest=${fullpath:-$HOME/.${source}}
        [[ -f ${source} ]] && ln -s $(pwd)/${source} ${dest}
}

# single home dotfiles
for i in bashrc vimrc vim gitconfig
do
        backupdf $i
        installdf $i
done

# single dot config files
for conffile in $HOME/.config/yamllint/config
do
        confdir=${conffile%/*}
        confname=${confdir##*/}
        backupdf ${conffile}
        [[ -d ${confdir} ]] || mkdir -p ${confdir}
        fullpath=${conffile} installdf ${confname}
done

