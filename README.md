# Rabbit MQ configurado em modo cluster com HA
Para utilização de um Rabbit MQ em formato de alta disponibilidade foi criado o docker-compose contendo a estrutura necessária de configuração.

Foi necessário configurar o haproxy para que o mesmo faça o papel de um loadbalancer e garanta a disponibilidade do serviço entre todos os nós do cluster e também foi criado uma estrutura de três aplicações rabbit rodando e com compartilhamento das informações através da policy **ha-mode** o que garante as informações serão replicadas para todos os nós do cluster e quando houver a queda de algum serviço no retorno do mesmo ele irá realizar a sincronização dos dados.

---

## Pre requisitos

Instalar [Docker](https://docs.docker.com/engine/install)

Instalar [Docker Compose](https://docs.docker.com/compose/install/)

---
## Iniciar Rabbit

```docker-compose up -d```

## Configurar Modo Cluster e filas
```sh configure_cluster.sh```

---

## Iniciar App Exemplo

```sh start_app.sh```


---
## Teste de Alta Disponibiliade
Para Testar a Alta disponibilidade sua fila padrão foi criada no nó *rabbitNode2* sendo dessa forma para fazer uma validação podera parar o nó em que sua fila se encontra com um dos comandos abaixo

```docker stop rabbitNode1```

```docker stop rabbitNode2```

```docker stop rabbitNode3```


Para acessar o Gerenciador do Rabbit acess http://localhost:15672 usuário: *root* senha: *123456* desta forma voce poderá ter acesso visual as configurações.

---

## Destruir ambiente

```sh stop_all.sh```

---