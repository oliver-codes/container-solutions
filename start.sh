#! /bin/bash

docker-compose build
docker-compose up -d
docker-compose scale backendA=3
docker-compose scale backendB=0