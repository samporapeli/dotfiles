FROM debian:11-slim

# possible values:
#   `compile` (compile from source)
#   `package` (use a package manager)
#   `download` (download binary)
# those strings can be given as parameters for niab-build
# https://stackoverflow.com/a/34600106
ARG install_type=compile

# set env variable
ENV INSTALL_TYPE=$install_type

# check that variable is valid
RUN echo -e "\n\tINSTALL_TYPE: $INSTALL_TYPE\n" && \
    (\
        test "$INSTALL_TYPE" = 'compile' || \
        test "$INSTALL_TYPE" = 'package' || \
        test "$INSTALL_TYPE" = 'download' \
    ) \
    || \
    ( \
        echo "\`\$INSTALL_TYPE\` cannot be \`$INSTALL_TYPE\`" && false \
    )

WORKDIR /nvim-install

RUN apt-get update
RUN apt-get install -y git curl

# neovim build requirements
# https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites

RUN if test "$INSTALL_TYPE" = 'compile'; then \
    apt-get install -y \
        ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen git && \
    git clone https://github.com/neovim/neovim \
    ;fi

WORKDIR /nvim-install/neovim

# create a stable version build (TODO: option to use dev version)
RUN if test "$INSTALL_TYPE" = 'compile'; then \
    git checkout stable && \
    make CMAKE_BUILD_TYPE=RelWithDebInfo && \
    make install && \
    git checkout master \
    ;fi

WORKDIR /nvim-install
RUN if test "$INSTALL_TYPE" = 'package'; then \
    apt-get install -y neovim \
    ;fi

# TODO: don't use a fixed url with hard coded version...
RUN if test "$INSTALL_TYPE" = 'download'; then \
    apt-get install -y tar && \
    curl -Lo nvim.tar.gz https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.tar.gz && \
    tar -xf nvim.tar.gz nvim-linux64/bin/nvim && \
    cp nvim-linux64/bin/nvim /usr/bin/nvim \
    ;fi


RUN rm -rf /nvim-install

# nvim & plugin requirements installed, create a user and switch to it
RUN useradd -ms /bin/bash nvim
USER nvim
WORKDIR /home/nvim

# load dotfiles temporarily from github
RUN git clone https://github.com/samporapeli/dotfiles.git dotfiles
# copy required files
# note that `aliases` adds `.vim` and `.config/nvim` as volumes, overriding just copied files
RUN cp -r dotfiles/.vim .vim
RUN mkdir -p .config && cp -r dotfiles/.config/nvim .config/nvim
# files copied, remove repository directory
RUN rm -rf dotfiles

# install vim-plug and use it to install plugins
# https://github.com/junegunn/vim-plug#unix-linux
RUN curl -fLo /home/nvim/.local/share/nvim/site/autoload/vim-plug/plug.vim \
    --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN nvim --headless -c PlugInstall -c PlugClean -c quit -c quit

# save the installation type to a file
RUN echo $INSTALL_TYPE > install_type.txt
