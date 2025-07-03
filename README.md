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
[~/Documents/document-packages.apt.txt]
including a full texlive install for creating documents using Latex.
This is not included in the base install, as the size of the installation is rather big.
Install packages from file:
```zsh
sudo apt install $(tr '\n' ' ' < ~/Documents/document-packages.apt.txt)
```
TODO: add helper function for this and use it here and in install script.

## Neovim
### `nide`: Neovim "IDE" with LSP
My vim plugin ecosystem configuration is a bit spaghetti, so I'm writing down the required steps for making the `nide` alias work as it should.

**WIP** Setting up:
* Install `npm`
* Make sure that the `$HOME/.config/nvim/` contains files from this repository, e.g., run `dot pull`.
* `nide -c PackerUpdate`

## [Node Version Manager](https://github.com/nvm-sh/nvm)
Install or update nvm: `install-nvm`

As loading nvm in .zshrc increases shell startup time, I decided to load nvm manually when needed: `. load-nvm` (or `source load-nvm`)

## Custom "apps"
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

## Misc
Configuration files to make programs work in certain (read: right :grin:) way, like .latexmkrc to use PDF as default format.
