#!/bin/bash

function install_dotfiles() {
    GIT_PATH="samporapeli/dotfiles.git"

    echo Do you want to replace current dotfiles, just clone the repository for viewing or do nothing?
    echo -n "Type 'replace', 'clone' or 'exit': " 
    read INSTALL_TYPE

    if [ "$INSTALL_TYPE" = "replace" ] || [ "$INSTALL_TYPE" = "clone" ]; then
        echo -n "Clone repository over ssh? [Y/n] "
        read USE_SSH
        if [ "$USE_SSH" = "y" ] || [ "$USE_SSH" = "" ]; then
            GIT_PREFIX="git@github.com:"
        elif [ "$USE_SSH" = "n" ]; then
            GIT_PREFIX="https://github.com/"
        else
            echo Invalid input, exiting
            exit
        fi
        if [ "$INSTALL_TYPE" = "replace" ]; then
            function dotfiles () {
                /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME/ $@
            }
            echo ".dotfiles" >> .gitignore
            dotfiles clone --bare $GIT_PREFIX$GIT_PATH $HOME/.dotfiles
            dotfiles config --local status.showUntrackedFiles no
        echo -n "Destroy previous configuration? This cannot be undone. [y/N] "
        read DESTROY_CONFIRMATION
        if [ "$DESTROY_CONFIRMATION" = "y" ]; then
            dotfiles checkout
        else
            echo Aborting...
            exit
        fi
        elif [ "$INSTALL_TYPE" = "clone" ]; then
            git clone $GIT_PREFIX$GIT_PATH
        fi
    elif [ "$INSTALL_TYPE" = "exit" ]; then
        exit
    else
        echo Invalid input, exiting
        exit
    fi
}
install_dotfiles
