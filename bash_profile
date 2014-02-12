export PS1="\u@\h:\w$ "
export CLICOLOR=1
export LSCOLORS=ExgxCxDxCxegedabagaced
export LESS='-R-i-P%f (%i/%m) line %lt/%L'

alias ll='ls -lh'

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# virtualenvwrapper
WORKON_HOME=/Users/brocks/PythonEnvs
export WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh

PATH=$PATH:/Users/brocks/bin:/usr/local/opt/ruby/bin
export PATH
