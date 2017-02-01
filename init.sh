#!/bin/bash
set -e

INIT_SEM=/tmp/initialized.sem

fresh_container() {
  [ ! -f $INIT_SEM ]
}

gems_up_to_date() {
  bundle check 1> /dev/null
}

log () {
  echo -e "\033[0;33m$(date "+%H:%M:%S")\033[0;37m ==> $1."
}

if ! gems_up_to_date; then
  log "Installing/Updating dependencies"
  bundle install
  log "Gems updated"
fi

if ! fresh_container; then
  echo "##############################"
  echo "# App initialization skipped #"
  echo "##############################"
else
  log "Initialization finished"
  touch $INIT_SEM
fi

exec /entrypoint.sh "$@"
