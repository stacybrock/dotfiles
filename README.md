# dotfiles

A repo for my dotfiles and other utility scripts.

## Structure

* Regular files in `dotfiles/` are symlink'd to `$HOME` (except README.md)
* The `bin/` directory is handled as a special case. Files within `bin/` are individually symlink'd to `$HOME/bin`
* Directories in `dotfiles/` are symlink'd to `$HOME`

Run `make_dotfiles.sh` to make everything go.
