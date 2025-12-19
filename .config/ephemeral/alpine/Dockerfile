FROM alpine:latest

# Install useful packages not included in the image by default
RUN apk add -u --no-cache git htop neovim sudo vim wget zsh

# Create non-root user 'dev'
RUN adduser -D -s /bin/zsh dev
RUN echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Root configuration complete, switch to dev user
USER dev
WORKDIR /home/dev

# Install dotfiles
# RUN SAMPORAPELI_DOTFILES_UNATTENDED_INSTALL=true bash <(curl -sL sampo.website/install-dotfiles.sh)

# Launch shell
CMD ["/bin/zsh"]
