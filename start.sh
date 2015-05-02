#! /bin/bash

docker-compose build
docker-compose up -d
docker-compose scale backenda=3
docker-compose scale backendb=0