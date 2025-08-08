# Some of my configuration files

## Installing dotfiles
### Using the installation script
I have created an interactive installation script, that is probably only useful for myself during setting up a new Linux environment. An easy way of setting up my dotfile system is to use `curl` or `wget` to fetch the install script and execute it. **Warning:** selecting 'replace' will overwrite old files, see below for more information.
```bash
bash <(curl -sL sampo.website/install-dotfiles.sh)
```
Or using `wget`
```bash
bash <(wget -qO - sampo.website/install-dotfiles.sh)
```
If you select 'clone', it just clones this repository. With 'replace' it creates a bare git repository in `~/.dotfiles/` and clones this repository there and checkout all the files in this repository into the home directory of the user. **This will overwrite all previous files with same paths than in repository. Make sure to backup beforehand** as there is no undo or automatic backups, or just clone the repository and do copying manually.

### Unattended usage of the installation script
When environment variable `SAMPORAPELI_DOTFILES_UNATTENDED_INSTALL` is set to `true`, the installation script will automatically install dotfiles and **replace the current configuration without any confirmation**.
Requires `bash`, `curl`, `envsubst` and `git` to be available.

```bash
SAMPORAPELI_DOTFILES_UNATTENDED_INSTALL=true bash <(curl -sL sampo.website/install-dotfiles.sh)
```

#### Notes
* The "`curl -sL https://url/script.sh | bash`" way does not currently work with the install script as it's interactive. However, `bash -c "$(curl -sL sampo.website/install-dotfiles.sh)"` will work.
* The actual file location is [https://raw.githubusercontent.com/samporapeli/dotfiles/main/Documents/install-dotfiles.sh](https://raw.githubusercontent.com/samporapeli/dotfiles/main/Documents/install-dotfiles.sh) and [sampo.website](https://sampo.website) has a redirect to that location.

### Manually
This might be a good idea if you only want some parts of the configuration.
1. Clone this repository, e. g. `git clone https://github.com/samporapeli/dotfiles.git`
2. In repository directory, load git submodules: `git submodule init && git submodule update`
3. Copy/link files from repository to needed locations in home directory.

## Document related packages
There's a small list of document editing related packages at
[~/Documents/document-packages.apt.txt](./Documents/document-packages.apt.txt)
including a full texlive install for creating documents using Latex.
This is not included in the base install, as the size of the installation is rather big.
Install packages from file:
```zsh
sudo apt install $(tr '\n' ' ' < ~/Documents/document-packages.apt.txt)
```
TODO: add helper function for this and use it here and in the install script.

## Neovim
The `nide` (**N**eovim **IDE**) alias starts Neovim with LSP and other tools configured.
Alias `e` starts `nvim` with a lighter configuration.

[~/.vim/vimrc](./vim/vimrc) is loaded in [~/.config/nvim/init.lua](./.config/nvim/init.lua), which allows using the same core configuration with `vim` and `nvim`, e.g. when working with external machines.

### Configuration with environment variables

[~/.config/nvim/lua/samporapeli/config/](./.config/nvim/lua/samporapeli/config/)

#### `NVIM_IDE`
Activate IDE-like features such as LSP and Copilot plugins.

Inteded to be used with `nide` alias, which sets the variable automatically for just that session.

#### `NVIM_ICON_FONT`
Enable patched font features, i.e., icons (Powerline, dev icons, etc.).

No direct alias (like `nide`). Add `export NVIM_ICON_FONT=1` to `~/.device.profile` **when** a [nerd patched font](https://www.nerdfonts.com/font-downloads) (Hack) is installed. Icons are disabled by default for compatibility between systems.

## [Node Version Manager](https://github.com/nvm-sh/nvm)
Install or update nvm: `install-nvm`

As loading nvm in .zshrc increases shell startup time, I decided to load nvm manually when needed: `. load-nvm` (or `source load-nvm`)

## Ephemeral environments

[~/.config/ephemeral](./.config/ephemeral/) contains docker image definitions for throwaway container creation.

Build a container image:

```zsh
docker build -t ephemeral-tumbleweed ~/.config/ephemeral/tumbleweed/
```

Create a new temporary container and launch a shell:

```zsh
docker run -it --rm ephemeral-tumbleweed
```

The container will be removed after exiting (`--rm`), no data is retained.

The command `:ephemeral` works as a shorthand for the above mentioned docker commands.
Run `:ephemeral --help` for details.

## Custom commands and scripts
### Aliases
[~/.aliases](./.aliases)
### [~/bin](./bin/)
This is the place for most of my custom scripts. Some are so simple that they could as well be aliases, while some are a bit more complicated. This is added to `$PATH`, so it is super easy to create new executables.
### [~/.shell_scripts](./.shell_scripts)
Some useful functions that can be used in other scripts.

## Plasma + [bspwm](https://github.com/baskerville/bspwm)
Plasma but bspwm instead of kwin. `picom` as a compositor.

## Arch Linux
This repository contains some configuration files related to my second computer running Arch Linux and i3wm.

## Windows
There is Windows specific configuration in [.windows-config](./.windows-config/) directory, currently only configuration file for Windows Terminal.
