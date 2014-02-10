#!/bin/bash

# make_dotfiles.sh
#
# This script creates symlinks from the home directory to files in ~/dotfiles
# Loosely based on:
# http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/

########## Configuration

DOTFILES="/Users/brocks/dotfiles/*"
BIN="/Users/brocks/dotfiles/bin/*"
BACKUP="/Users/brocks/.dotfiles_old"

##########

# create .dotfiles_old in homedir
echo "creating $BACKUP for backing up existing dotfiles..."
mkdir -p $BACKUP

# grab homedir
home=`echo ~`

# create dotfile symlinks
echo "processing dotfiles..."
for file in $DOTFILES
do
    f=`basename $file`
    if [ -f "$file" ]; then
        # check if symlink already exists
        if [ -L "$home/.$f" ]; then
            echo "  symlink for $f already exists, skipping..."
            continue
        fi
        # check if dotfile is a regular file; if so, back it up
        if [ -f "$home/.$f" ]; then
            echo "  moving ~/.$f to $BACKUP"
            mv ~/.$f $BACKUP
        fi
        # now create the symlink
        echo "  creating symlink: ~/.$f -> $file"
        ln -s $file ~/.$f
    fi
done

# create bin file symlinks
echo "processing bin files..."
for file in $BIN
do
    f=`basename $file`
    if [ -L "$home/bin/$f" ]; then
        echo "  symlink for $file already exists, skipping..."
        continue
    fi
    echo "  creating symlink: ~/bin/$f -> $file"
    ln -s $file ~/bin/$f
done
