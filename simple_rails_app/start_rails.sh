#!/bin/bash


trap 'excode=$?; cleanup; echo $excode; exit' EXIT HUP INT QUIT PIPE TERM

function cleanup {
  redis-cli -h frontend lrem frontend:$DOMAIN 1 http://$IP:3000
}

if (($(redis-cli -h frontend exists frontend:$DOMAIN) == 0))
then
  echo 'Frontend identifier doesnt exist. Creating'
  redis-cli -h frontend rpush frontend:$DOMAIN dockerdev
else
  echo 'The frontend identifier already exists. Skipping.'
fi

rake db:create db:setup

rails server --port 3000 --binding 0.0.0.0 &

IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
redis-cli -h frontend rpush frontend:$DOMAIN http://$IP:3000

wait $1