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
If you select 'clone', it just clones this repository. With 'replace' it creates a bare git repository in `~/.dotfiles/` and clones this repository there and checkout all the files in this repository into the home directory of the user. **This will overwrite all previous files with same paths than in repository. Make sure to backup beforehand** as there is no undo or automatic backups, or just clone the repository and do copying manually. When selecting replace, it will also install [oh-my-zsh](https://ohmyz.sh/#install) and load git submodules (vim plugins).

#### Notes
* The "`curl -sL https://url/script.sh | bash`" way does not currently work with the install script as it's interactive. However, `bash -c "$(curl -sL sampo.website/install-dotfiles.sh)"` will work.
* The actual file location is [https://raw.githubusercontent.com/samporapeli/dotfiles/master/Documents/install-dotfiles.sh](https://raw.githubusercontent.com/samporapeli/dotfiles/master/Documents/install-dotfiles.sh) and [sampo.website](https://sampo.website) has a redirect to that location.

### Manually
This might be a good idea if you only want some parts of the configuration.
1. Clone this repository, e. g. `git clone https://github.com/samporapeli/dotfiles.git`
2. In repository directory, load git submodules: `git submodule init && git submodule update`
3. Copy/link files from repository to needed locations in home directory.

## How I manage vim plugins 
Vim 8 introduced native package management, and that is what I use. [Here](https://shapeshed.com/vim-packages/) you can find a good tutorial on how to set it up with `git submodule`. I currently use the path [~/.vim/pack/sampo/start](.vim/pack/sampo/start) for all plugins.

However, I created a small tool that automates some steps during adding, deleting and updating plugins. It is located in [~/bin/vim-plugin](./bin/vim-plugin). Should I just use some actual vim plugin manager? Probably, but I couldn't resist writing this.

Basic usage (with example plugin):
```bash
# Add a new plugin
vim-plugin add https://github.com/vim-airline/vim-airline.git
# Update all installed plugins and generate helptags
vim-plugin update
# Delete a plugin
vim-plugin delete vim-airline
```
