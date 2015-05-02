#! /bin/bash
git pull
docker-compose build

if docker-compose ps | grep -q containersolutionsassignment_backendA
then
docker-compose scale backendb=3
docker-compose scale backenda=0
else
docker-compose scale backenda=3
docker-compose scale backendb=0
fi