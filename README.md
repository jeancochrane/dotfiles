# dotfiles

This repo stores my dev env config files ("dotfiles").

## Installation

Files are managed using [GNU
Stow](https://www.gnu.org/software/stow/manual/stow.html). Make sure you have
stow, tmux, and helix installed.

Clone this repo into your home directory:

```
cd ~
git clone git@github.com:jeancochrane/dotfiles.git
cd dotfiles
```

Run stow to symlink the config files to their proper place in the home
directory:

```
stow bash
stow tmux
stow helix
```

## Additional configuration

Packages that need to be installed (I should script this installation someday):

- Helix: `sudo snap install helix`
- Tmux: `sudo apt install tmux`
- Python + pip: `sudo apt install python3-pip`
- uv: `curl -LsSf https://astral.sh/uv/install.sh | sh`

TODO: Install lazygit.
TODO: Language servers.
