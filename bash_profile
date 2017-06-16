export PS1="\u@\h:\w$ "
export CLICOLOR=1
export LSCOLORS=ExgxCxDxCxegedabagaced
export LESS='-R-i-P%f (%i/%m) line %lt/%L'
export EDITOR='vi'

# aliases
alias ll='ls -lh'
alias grep='grep --color=auto'
alias cal='gcal'
alias groot='cd "`git root`"'
eval "$(thefuck --alias)"

# bash history tweaks
export HISTFILESIZE=10000
export HISTSIZE=5000
export PROMPT_COMMAND='history -a'
shopt -s histappend

# other bash tweaks
shopt -s no_empty_cmd_completion

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# go
export GOPATH=$HOME/.go
PATH=$PATH:$GOPATH/bin

# z
. `brew --prefix`/etc/profile.d/z.sh

# PATH
PATH=$HOME/bin:/usr/local/opt/ruby/bin:$PATH
PATH=$PATH:/usr/local/opt/node@6/bin
export PATH


case $(uname -s) in
*Linux*)
    # Linux-specific things here
    ;;
*Darwin*)
    # homebrew disable google analytics tracking
    export HOMEBREW_NO_ANALYTICS=1

    [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
    ;;
esac
