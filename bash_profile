export PS1="\u@\h:\w$ "
export CLICOLOR=1
export LSCOLORS=ExgxCxDxCxegedabagaced
export LESS='-R-i-P%f (%i/%m) line %lt/%L'

alias ll='ls -lh'
alias marked='open -a Marked'

# bash history tweaks
export HISTFILESIZE=10000
export HISTSIZE=5000
export PROMPT_COMMAND='history -a'
shopt -s histappend

# other bash tweaks
shopt -s no_empty_cmd_completion

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# virtualenvwrapper
WORKON_HOME=/Users/brocks/PythonEnvs
export WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh

PATH=$PATH:/Users/brocks/bin:/usr/local/opt/ruby/bin
export PATH