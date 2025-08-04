#!/bin/bash

function install_dotfiles() {
    # Get the necessary functions used
    if command -v curl &> /dev/null; then
        source <(curl -s https://raw.githubusercontent.com/samporapeli/dotfiles/main/.shell_scripts)
    elif command -v wget /dev/null; then
        source <(wget -qO - https://raw.githubusercontent.com/samporapeli/dotfiles/main/.shell_scripts)
    else
        echo "You must have curl or wget installed to complete installation."
        exit 1
    fi

    GIT_PATH="samporapeli/dotfiles.git"

    echo Do you want to replace current dotfiles, just clone the repository for viewing or do nothing?
    echo -n "Type 'replace', 'clone' or 'exit': " 
    read INSTALL_TYPE

    if [ "$INSTALL_TYPE" = "replace" ] || [ "$INSTALL_TYPE" = "clone" ]; then
        if ! command_exists git; then
            echo "Git must be installed"
            if echo -n "Try to install now? " && y_n_dialog y; then
                install_packages git
            else
                echo "Please install git manually before running this installation script."
                echo "Aborting..."
                exit 1
            fi
        fi
        echo -n "Clone repository over ssh? "
        if y_n_dialog y; then
            GIT_PREFIX="git@github.com:"
        else
            GIT_PREFIX="https://github.com/"
        fi
        if command_exists apt-get; then
            echo -n "Install some useful packages (list: https://raw.githubusercontent.com/samporapeli/dotfiles/main/Documents/useful_packages_apt.txt) "
            if y_n_dialog y; then
                if command_exists curl; then
                    install_packages  $(curl -s https://raw.githubusercontent.com/samporapeli/dotfiles/main/Documents/useful_packages_apt.txt | tr '\n' ' ')
                elif command_exists wget; then
                    install_packages $(wget -qO - https://raw.githubusercontent.com/samporapeli/dotfiles/main/Documents/useful_packages_apt.txt | tr '\n' ' ')
                else
                    echo "curl or wget required, skipping..."
                fi
            fi
        fi
        if ! command_exists zsh; then
            echo -n "Install zsh? "
            if y_n_dialog y; then
                install_packages zsh
            fi
        fi
        if [ "$INSTALL_TYPE" = "replace" ]; then
            echo ".dotfiles" >> .gitignore
            dotfiles clone --bare $GIT_PREFIX$GIT_PATH $HOME/.dotfiles
            dotfiles config --local status.showUntrackedFiles no
            echo -n "Destroy previous configuration? This cannot be undone. "
            if y_n_dialog n; then
                echo Copying files...
                dotfiles checkout -f main
                echo Downloading git submodules...
                dotfiles submodule init
                dotfiles submodule update
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
