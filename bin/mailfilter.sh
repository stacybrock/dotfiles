#!/usr/bin/env bash

MAILFILTER_DIR=$HOME/tools/o365-mail-filter

KILL_ONLY=false
PASS_ONLY=false
RUN_ONLY=false
while getopts ":kpr" opt; do
  case ${opt} in
    k ) # process option k
        KILL_ONLY=true
      ;;
    p ) # process option p
        PASS_ONLY=true
      ;;
    r ) # process option r
        RUN_ONLY=true
      ;;
    \? )
        cat << EOF
Usage: kick_mailfilter.sh [-k] [-p] [-r]

If no options are given, launches the mailfilter script via launchd

Options
  -k  terminate running mailfilter
  -p  read creds into envvars out of pass
  -r  run mailfilter manually via python virtualenv
EOF
        exit 1
      ;;
  esac
done
shift $((OPTIND -1))

# check for -k (kill only) flag and bail early if it's set
if $KILL_ONLY; then
    launchctl stop local.mailfilter
    echo `launchctl list | grep 'local.mailfilter'`
    exit 0
fi

# get username/password from pass, then bail out
if $PASS_ONLY; then
    # IFS=':' read -ra creds <<< `pass OSU/ONID`
    app_client_id=`pass Azure/brock-mail-filter/client_id`
    app_secret_key=`pass Azure/brock-mail-filter/secret_key`
    app_tenant_id=`pass Azure/oregonstateuniv_tenant_id`
    launchctl setenv APP_CLIENT_ID $app_client_id
    launchctl setenv APP_SECRET_KEY $app_secret_key
    launchctl setenv APP_TENANT_ID $app_tenant_id
    exit 0
fi

# enable virtualenv and run mail-filter.py
if $RUN_ONLY; then
    source $HOME/.virtualenvs/o365mailfilter/bin/activate
    cd $MAILFILTER_DIR
    python mail-filter.py
    exit 0
fi

launchctl start local.mailfilter
sleep 2
echo `launchctl list | grep 'local.mailfilter'`
