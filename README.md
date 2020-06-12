# My .dotfiles

## Instructions

### GNU Stow

```shell
# Add GNU PPA to get stow version >= 2.3
sudo add-apt-repository ppa:dns/gnu
sudo apt-get update

# Install GNU Stow
sudo apt install stow

# Clone this repo to ~/.dotfiles
git clone https://github.com/Hasnep/dotfiles.git ~/.dotfiles

# Run stow on all the packages
cd ~/.dotfiles
stow git julia r ssh zsh
```

### dconf

To restore from files to dconf:

```shell
dconf load /com/gexperts/Tilix/ < ~/.dotfiles/tilix/tilix.conf
dconf load /com/solus-project/ < ~/.dotfiles/budgie/budgie.conf
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < ~/.dotfiles/gnome/keybindings.conf
```

To backup from dconf to files:

```shell
dconf dump /com/gexperts/Tilix/ > ~/.dotfiles/tilix/tilix.conf
dconf dump /com/solus-project/ > ~/.dotfiles/budgie/budgie.conf
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > ~/.dotfiles/gnome/keybindings.conf 
```
