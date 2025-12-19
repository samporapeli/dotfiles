FROM opensuse/tumbleweed

# Install useful packages not included in the image by default
RUN zypper refresh && zypper install -y envsubst git htop man neovim tmux sudo vim wget zsh

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Create non-root user 'dev'
RUN useradd dev -m -s /bin/zsh
RUN echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set up tmux
RUN mkdir -p /run/tmux && chmod a+rwx,o+t /run/tmux

# Root configuration complete, switch to dev user
USER dev
WORKDIR /home/dev

# Install dotfiles
RUN SAMPORAPELI_DOTFILES_UNATTENDED_INSTALL=true bash <(curl -sL sampo.website/install-dotfiles.sh)

# Launch shell
CMD ["/bin/zsh"]
