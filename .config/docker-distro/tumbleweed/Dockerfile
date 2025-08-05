FROM opensuse/tumbleweed

# Install useful packages not included in the image by default
RUN zypper refresh && zypper install -y envsubst git htop man neovim sudo vim wget zsh

# Create non-root user 'dev'
RUN useradd dev -m -s /bin/zsh
RUN echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Root configuration complete, switch to dev user
USER dev
WORKDIR /home/dev

# Install dotfiles
RUN SAMPORAPELI_DOTFILES_UNATTENDED_INSTALL=true bash <(curl -sL sampo.website/install-dotfiles.sh)

# Launch shell
CMD ["/bin/zsh"]
