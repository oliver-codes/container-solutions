#! /bin/bash
git pull
docker-compose build

if docker-compose ps | grep -q containersolutionsassignment_backendA
then
docker-compose scale backendB=3
docker-compose scale backendA=0
else
docker-compose scale backendA=3
docker-compose scale backendB=0
fi