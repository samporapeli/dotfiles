alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME/"
echo ".dotfiles" >> .gitignore
git clone --bare git@github.com:samporapeli/dotfiles.git $HOME/.dotfiles
mkdir -p .dotfiles-backup && dotfiles checkout 2>&1 |
    egrep "\s+\." |
    awk {"print $1"} |
    xargs -I{} mv {} .dotfiles-backup/{}
dotfiles config --local status.ShowUntrackedFiles no
