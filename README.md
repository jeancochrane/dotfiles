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
stow R
```

## Additional configuration

Packages that need to be installed (I should script this installation someday):

- Helix: `sudo snap install helix`
- Tmux: `sudo apt install tmux`
- Python + pip: `sudo apt install python3-pip`
- [Terraform](https://developer.hashicorp.com/terraform/install)
- [R](https://cran.r-project.org/bin/linux/ubuntu/fullREADME.html)
  - Make sure [packages are signed
    correctly](https://cran.r-project.org/bin/linux/ubuntu/fullREADME.html#secure-apt).
    The instructions are outdated, so we should instead follow the Terraform steps:
      1. Download the public key and output it to file at
         `/usr/share/keyrings/cran-keyring.gpg`
      2. Make a new apt sources list in `/etc/apt/sources.list.d/cran.list`
      2. Tweak the `deb` entry in sources list to include
         `[arch=amd64 signed-by=/usr/share/keyrings/cran-keyring.gpg]`
- uv: `curl -LsSf https://astral.sh/uv/install.sh | sh`
- [lazygit](https://github.com/jesseduffield/lazygit?tab=readme-ov-file#debian-and-ubuntu)
- [Node](https://nodejs.org/en/download)
- [Git LFS](https://github.com/git-lfs/git-lfs/blob/main/INSTALLING.md)
- `yq`: `sudo snap install yq`
- `jq`: `sudo apt install jq libjq-dev`
- Language servers:
  - ruff: `uv tool install ruff`
  - ty: `uv tool install ty`
  - terraform: `sudo apt install terraform-ls`
    - Assumes Terraform installation step above is complete
  - `yaml-language-server`: `npm i -g yaml-language-server`
    - Assumes Node installation step above is complete
- Various system packages:
  - `libcurl`, required for R `curl` package: `sudo apt install libcurl4-openssl-dev`
  - `libssl`, required for R `openssl` package: `sudo apt install libssl-dev`
  - `libxml2`, required for R `xml2` package: `sudo apt install libxml2-dev`
  - `libgit2-dev`, required for R `git2r` package: `sudo apt install libgit2-dev`
  - `libpoppler-cpp-dev`, required for R `pdftools` package: `sudo apt install libpoppler-cpp-dev`
  - `default-jdk` (Java Development Kit), required for R `tabulapdf` package: `sudo apt install default-jdk`
  - `libprotobuf-dev`, required for R `protolite`: `sudo apt install libprotobuf-dev protobuf-compiler`
  - Geospatial packages required for R `sf` package: `sudo apt install gdal-bin libudunits2-dev libgdal-dev libgeos-dev libproj-dev libsqlite3-dev`
  - Graphic devices (required for tidyverse): `sudo apt install libpng-dev libfontconfig1-dev libfreetype6-dev`
