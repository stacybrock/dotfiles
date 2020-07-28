#!/usr/bin/env bash

MAILFILTER_DIR=$HOME/tools/mail-filter

KILL_ONLY=false
while getopts ":k" opt; do
  case ${opt} in
    k ) # process option h
        KILL_ONLY=true
      ;;
    \? )
        echo "Usage: kill_mailfilter.sh [-k]"
        exit 1
      ;;
  esac
done
shift $((OPTIND -1))

PID=`pgrep -f mail-filter.py`

# kill mail-filter.py if it's running
if [[ $PID != "" ]]; then
    echo "killed pid: $PID"

    kill -9 $PID
fi

# check for -k (kill only) flag and bail early if it's set
if $KILL_ONLY; then
    exit 0
fi

# enable virtualenv and run mail-filter.py
source $HOME/.virtualenvs/mail-filter/bin/activate
cd $MAILFILTER_DIR
python mail-filter.py

PID=`pgrep -f mail-filter.py`
echo "new pid: $PID"
