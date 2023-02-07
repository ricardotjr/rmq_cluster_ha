#!/bin/bash

docker rm -f app_producer
docker rm -f app_consumer

docker rmi app

docker-compose down --remove-orphans -v