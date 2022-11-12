SHORTNAME=`hostname -s`
if [[ $SHORTNAME == 'BROCK-MBP14' ]]; then
    export PS1="\[\e[1;37m\]\u@MBP14:\w$ \[\e[m\]"
else
    export PS1="\[\e[1;37m\]\u@\h:\w$ \[\e[m\]"
fi
export CLICOLOR=1
export LSCOLORS=ExgxCxDxCxegedabagaced
export LESS='-R-i-P%f (%i/%m) line %lt/%L'
export EDITOR=vim
export ACK_PAGER_COLOR='less -R'

OS_FAMILY=`uname -s`
OS_ARCH=`uname -m`

# setup homebrew, if on macOS
if [[ $OS_FAMILY == 'Darwin' && $OS_ARCH='arm64' ]]; then
    # M1 mac detected
    HOMEBREW_PREFIX=/opt/homebrew
else
    # Intel mac detected
    HOMEBREW_PREFIX=/usr/local
fi
export PATH="$HOMEBREW_PREFIX/bin:$PATH"

# aliases
alias ll='ls -lh'
alias grep='grep --color=auto'
alias cal='ncal -C'
alias groot='cd "`git root`"'
eval "$(thefuck --alias)"

# cdup - quickly climb directory trees
cdup() {
  DOTS=`$HOME/bin/cdup $1`
  RETVAL=$?
  if [ $RETVAL -eq 0 ]; then
    cd $DOTS
  fi
}

# bash history tweaks
export HISTFILESIZE=10000
export HISTSIZE=5000
export PROMPT_COMMAND='history -a'
shopt -s histappend

# other bash tweaks
shopt -s no_empty_cmd_completion

# gpg
GPG_TTY=$(tty)
export GPG_TTY

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
export PATH=$(pyenv root)/shims:$PATH
pyenv virtualenvwrapper

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# aws-vault
export AWS_VAULT_PASS_PREFIX=aws-vault
export AWS_VAULT_BACKEND=pass

# go
export GOPATH=$HOME/.go
PATH=$PATH:$GOPATH/bin

# exercism bash completion
if [ -f ~/.config/exercism/exercism_completion.bash ]; then
  . ~/.config/exercism/exercism_completion.bash
fi

# PATH
PATH=$HOME/bin:$PATH

# OS-specific things
case $(uname -s) in
*Linux*)
    # Linux-specific things here
    ;;
*Darwin*)
    # alias to override system vi
    alias vi=/usr/local/bin/vim

    # homebrew disable google analytics tracking
    export HOMEBREW_NO_ANALYTICS=1

    # java on mac os
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home
    export PATH=$PATH:/usr/local/Cellar/maven/3.5.2/bin

    # set some paths for homebrew-installed languages
    PATH=$PATH:$HOMEBREW_PREFIX/opt/ruby/bin
    PATH=$PATH:$HOMEBREW_PREFIX/opt/node/bin
    PATH=$PATH:$HOMEBREW_PREFIX/opt/perl/bin

    # make homebrew play nicely with pyenv
    alias brew='env PATH="${PATH//$(pyenv root)/shims:/}" brew'

    # z
    . `brew --prefix`/etc/profile.d/z.sh

    [[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]] && . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
    ;;
esac

export PATH
