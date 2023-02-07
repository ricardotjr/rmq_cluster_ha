#!/bin/bash

docker exec -ti rabbitNode2 bash -c "rabbitmqctl stop_app"
docker exec -ti rabbitNode2 bash -c "rabbitmqctl join_cluster rabbit@node1.rabbit"
docker exec -ti rabbitNode2 bash -c "rabbitmqctl start_app"
docker exec -ti rabbitNode3 bash -c "rabbitmqctl stop_app"
docker exec -ti rabbitNode3 bash -c "rabbitmqctl join_cluster rabbit@node1.rabbit"
docker exec -ti rabbitNode3 bash -c "rabbitmqctl start_app"

sleep 5

docker exec -ti rabbitNode1 bash -c "rabbitmqctl add_user entregador 123456"
docker exec -ti rabbitNode1 bash -c "rabbitmqctl add_vhost brasil"
docker exec -ti rabbitNode1 bash -c "rabbitmqctl set_permissions --vhost brasil entregador '.*' '.*' '.*'"
docker exec -ti rabbitNode1 bash -c "rabbitmqctl set_permissions --vhost brasil root '.*' '.*' '.*'"
docker exec -ti rabbitNode1 bash -c "rabbitmqadmin --vhost=brasil --username=root --password=123456 declare queue name=uberlandia node=rabbit@node2.rabbit"
docker exec -ti rabbitNode1 bash -c "rabbitmqadmin --vhost=brasil --username=root --password=123456 declare exchange name=minas_gerais type=direct"
docker exec -ti rabbitNode1 bash -c "rabbitmqadmin --vhost=brasil --username=root --password=123456 declare binding source=minas_gerais destination=uberlandia routing_key=udi"


docker exec rabbitNode1 rabbitmqctl set_policy ha "." '{"ha-mode":"all"}' --vhost=brasil