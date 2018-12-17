export PS1="\[\e[0;36m\]\u@\h:\w$ \[\e[m\]"
export CLICOLOR=1
export LSCOLORS=ExgxCxDxCxegedabagaced
export LESS='-R-i-P%f (%i/%m) line %lt/%L'
export EDITOR=vim

# aliases
alias ll='ls -lh'
alias grep='grep --color=auto'
alias cal='gcal'
alias groot='cd "`git root`"'
alias jrnlw='jrnl -from "last week"'
eval "$(thefuck --alias)"

# cdup - quickly climb directory trees
cdup() {
  cd `$HOME/bin/cdup $1`
}

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
pyenv virtualenvwrapper

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
    PATH=$PATH:/usr/local/opt/ruby/bin
    PATH=$PATH:/usr/local/opt/node/bin
    PATH=$PATH:/usr/local/opt/perl/bin

    # z
    . `brew --prefix`/etc/profile.d/z.sh

    [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
    ;;
esac

export PATH
