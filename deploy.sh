#! /bin/bash
git pull
docker-compose build

wait_till_backend_is_serving_requests() {
  IP=$(docker ps | grep backend$1 | awk '{print $1}' | tail -n 1 | xargs docker inspect | grep IPAddress | cut -d '"' -f 4)

  until $(curl --output /dev/null --silent --head --fail http://$IP:3000); do
    printf '.'
    sleep 5
  done
}

if docker-compose ps | grep -q containersolutionsassignment_backenda
then
  docker-compose scale backendb=3
  wait_till_backend_is_serving_requests "b"
  docker-compose scale backenda=0
else
  docker-compose scale backenda=3
  wait_till_backend_is_serving_requests "a"
  docker-compose scale backendb=0
fi