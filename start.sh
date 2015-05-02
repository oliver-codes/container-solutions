#! /bin/bash

docker-compose build
docker-compose up -d
docker-compose scale backend_a=3
docker-compose scale backend_b=0