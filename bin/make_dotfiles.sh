#!/bin/bash

# make_dotfiles.sh
#
# This script creates symlinks from the home directory to files in ~/dotfiles
# Loosely based on:
# http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/

########## Configuration

DOTFILES="$HOME/dotfiles/*"
BIN="$HOME/dotfiles/bin/*"
BACKUP="$HOME/.dotfiles_old"
IGNORE_DOTFILES=("README.md" "bin")
IGNORE_BINFILES=("Gemfile" "Gemfile.lock" "config.yml" "config.yml-dist" "bus.rb" "util.rb")

########## Utility Functions

# hasElement
# returns true if element is contained in the given array
hasElement() {
    local element
    for element in "${@:2}"; do [[ "$element" == "$1" ]] && return 0; done
    return 1
}

##########

# create .dotfiles_old in homedir
echo "creating $BACKUP for backing up existing dotfiles..."
mkdir -p $BACKUP

# create dotfile symlinks
echo "processing dotfiles..."
for file in $DOTFILES
do
    f=`basename $file`

    # check if this file should be ignored
    if hasElement $f "${IGNORE_DOTFILES[@]}"; then continue; fi

    if [[ -f "$file" || -d "$file" ]]; then
        # check if symlink already exists
        if [ -L "$HOME/.$f" ]; then
            echo "  skipping symlink for $f (already exists)..."
            continue
        fi
        # check if dotfile is a regular file; if so, back it up
        if [[ -f "$HOME/.$f" || -d "$HOME/.$f" ]]; then
            echo "  moving ~/.$f to $BACKUP"
            mv ~/.$f $BACKUP
        fi
        # now create the symlink
        echo "  creating symlink: ~/.$f -> $file"
        ln -s $file ~/.$f
    fi
done

# does bin dir exist?
if [[ -d "$HOME/bin" ]]; then
    echo "$HOME/bin exists"
else
    echo "creating $HOME/bin"
    mkdir $HOME/bin
fi

# create bin file symlinks
echo "processing bin files..."
for file in $BIN
do
    f=`basename $file`

    # check if this file should be ignored
    if hasElement $f "${IGNORE_BINFILES[@]}"; then continue; fi

    if [ -L "$HOME/bin/$f" ]; then
        echo "  skipping symlink for $file (already exists)..."
        continue
    fi
    echo "  creating symlink: ~/bin/$f -> $file"
    ln -s $file ~/bin/$f
done
