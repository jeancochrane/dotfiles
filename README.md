# dotfiles

This repo stores my dev env config files ("dotfiles").

## Installation

Files are managed using [GNU
Stow](https://www.gnu.org/software/stow/manual/stow.html). Make sure you have
stow installed:

```
sudo apt install stow
```

Clone this repo into your home directory:

```
cd ~
git clone git@github.com:jeancochrane/dotfiles.git
```

Run stow to symlink the config files to their proper place in the home
directory:

```
stow bash
stow tmux
stow vim
stow nvim
```
