#!/bin/bash

rake db:create db:setup

IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')


if (($(redis-cli -h frontend exists frontend:$DOMAIN) == 0))
then
  echo 'Frontend identifier doesnt exist. Creating'
  redis-cli -h frontend rpush frontend:$DOMAIN dockerdev
else
  echo 'The frontend identifier already exists. Skipping.'
fi

redis-cli -h frontend rpush frontend:$DOMAIN http://$IP:3000

trap 'excode=$?; cleanup; echo $excode; exit' EXIT HUP INT QUIT PIPE TERM

function cleanup {
  redis-cli -h frontend lrem frontend:$DOMAIN 1 http://$IP:3000
}

rails server --port 3000 --binding 0.0.0.0 &

wait $1