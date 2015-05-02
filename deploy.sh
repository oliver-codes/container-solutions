#! /bin/bash
git pull
docker-compose build

if docker-compose ps | grep -q containersolutionsassignment_backend_a
then
docker-compose scale backend_b=3
docker-compose scale backend_a=0
else
docker-compose scale backend_b=0
docker-compose scale backend_a=3
fi