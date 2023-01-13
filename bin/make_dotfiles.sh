#!/usr/bin/env bash

# make_dotfiles.sh
#
# This script creates symlinks from the home directory to files in ~/dotfiles
# Loosely based on:
# http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/

##### Configuration

DOTFILES="$HOME/dotfiles/*"
BIN="$HOME/dotfiles/bin/*"
BACKUP="$HOME/.dotfiles_old"
IGNORE_DOTFILES=("README.md" "bin")
IGNORE_BINFILES=("Gemfile" "Gemfile.lock" "config.yml" "config.yml-dist" "bus.rb" "util.rb" "list_adocs.py")

##### Utility Functions

# has_element
# returns true if element is contained in the given array
has_element() {
    local element
    for element in "${@:2}"; do [[ "$element" == "$1" ]] && return 0; done
    return 1
}

# setup_colors
# define color codes for pretty, pretty output
setup_colors() {
    if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
        NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' BOLDGREEN='\033[1;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' BOLDCYAN='\033[1;36m' YELLOW='\033[1;33m'
    else
        NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
    fi
}

# msg
# write nicely to stdout
msg() {
    echo >&2 -e "${1-}"
}

##### Pre-Magic

setup_colors

##### Where the Magic Happens

msg "${BOLDCYAN}Creating directories...${NOFORMAT}"

# create .dotfiles_old/ in homedir
if [[ -d "$BACKUP" ]]; then
    msg "  $BACKUP already exists, skipping..."
else
    msg "  ${GREEN}Creating $BACKUP for backing up existing dotfiles...${NOFORMAT}"
    mkdir -p $BACKUP
fi

# create bin/ in homedir
if [[ -d "$HOME/bin" ]]; then
    msg "  $HOME/bin already exists, skipping..."
else
    msg "  ${GREEN}Creating $HOME/bin${NOFORMAT}"
    mkdir $HOME/bin
fi

# create dotfile symlinks
msg "${BOLDCYAN}Processing dotfiles...${NOFORMAT}"
for file in $DOTFILES
do
    f=`basename $file`

    # check if this file should be ignored
    if has_element $f "${IGNORE_DOTFILES[@]}"; then continue; fi

    if [[ -f "$file" || -d "$file" ]]; then
        # check if symlink already exists
        if [ -L "$HOME/.$f" ]; then
            msg "  Symlink for $f already exists..."
            continue
        fi
        # check if dotfile is a regular file or dir; if so, back it up
        if [[ -f "$HOME/.$f" || -d "$HOME/.$f" ]]; then
            msg "  ${GREEN}Moving ${BOLDGREEN}~/.$f${GREEN} to ${BOLDGREEN}$BACKUP${NOFORMAT}"
            mv ~/.$f $BACKUP
        fi
        # now create the symlink
        msg "  ${GREEN}Creating symlink: ${BOLDGREEN}~/.$f${GREEN} -> ${BOLDGREEN}$file${NOFORMAT}"
        ln -s $file ~/.$f
    fi
done

# create bin file symlinks
msg "${BOLDCYAN}Processing bin files...${NOFORMAT}"
for file in $BIN
do
    f=`basename $file`

    # check if this file should be ignored
    if has_element $f "${IGNORE_BINFILES[@]}"; then continue; fi

    if [ -L "$HOME/bin/$f" ]; then
        msg "  Symlink for $file already exists..."
        continue
    fi
    msg "  ${GREEN}Creating symlink: ${BOLDGREEN}~/bin/$f${GREEN} -> ${BOLDGREEN}$file${NOFORMAT}"
    ln -s $file ~/bin/$f
done

msg "${GREEN}Done.${NOFORMAT}"
