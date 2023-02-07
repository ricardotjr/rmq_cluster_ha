#!/bin/bash

docker build -t app .

docker run -d --name app_producer -e PRODUCER=1 --network rmq_cluster_ha_cluster-network --restart always app
docker run -d --name app_consumer --network rmq_cluster_ha_cluster-network --restart always app