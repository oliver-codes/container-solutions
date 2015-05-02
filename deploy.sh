#! /bin/bash
git pull
docker-compose build

if docker-compose ps | grep -q containersolutionsassignment_backenda
then
  docker-compose scale backendb=3

  IP=$(docker ps | grep backendb | awk '{print $1}' | head -n 1 | xargs docker inspect | grep IPAddress | cut -d '"' -f 4)

  until $(curl --output /dev/null --silent --head --fail http://$IP:3000); do
    printf '.'
    sleep 5
  done

  docker-compose scale backenda=0
else
  docker-compose scale backenda=3

  IP=$(docker ps | grep backenda | awk '{print $1}' | head -n 1 | xargs docker inspect | grep IPAddress | cut -d '"' -f 4)

  until $(curl --output /dev/null --silent --head --fail http://$IP:3000); do
    printf '.'
    sleep 5
  done

  docker-compose scale backendb=0
fi