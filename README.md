# My .dotfiles

## Instructions

```shell
# Install git
sudo apt install git

# Create an alias
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# Clone the repo
git clone --bare https://github.com/Hasnep/dotfiles.git $HOME/.dotfiles

# Check out the repo
dotfiles checkout

# Don't show untracked files
dotfiles config --local status.showUntrackedFiles no
```

### dconf

To restore from files to dconf:

```shell
dconf load /com/gexperts/Tilix/ < ~/tilix/tilix.conf
dconf load /com/solus-project/ < ~/budgie/budgie.conf
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < ~/gnome/keybindings.conf
```

To backup from dconf to files:

```shell
dconf dump /com/gexperts/Tilix/ > ~/tilix/tilix.conf
dconf dump /com/solus-project/ > ~/budgie/budgie.conf
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > ~/gnome/keybindings.conf
```
