import pika, sys, os, time


def consumer(connection):
    channel = connection.channel()
    channel.queue_declare(queue='uberlandia', durable=True)
    channel.basic_qos(prefetch_count=1)

    def callback(ch, method, properties, body):
        print(" [x] Received %r" % body)

    channel.basic_consume(queue='uberlandia', on_message_callback=callback, auto_ack=True)

    print(' [*] Waiting for messages.')
    channel.start_consuming()


def producer(connection):
    channel = connection.channel()
    val = 0
    while True:
        msg = '{"index": ' + str(val) + '}'
        val = val + 1
        channel.basic_publish(exchange='minas_gerais', routing_key='udi', body=msg)
        print(f" [x] Sent '{msg}'")
        time.sleep(1)
    connection.close()


if __name__ == '__main__':
    try:
        connection = pika.BlockingConnection(pika.ConnectionParameters(host='haproxy', port=5672, virtual_host="brasil", credentials=pika.PlainCredentials(username="entregador", password="123456")))
        if os.environ.get("PRODUCER"):
            producer(connection)
        else:
            consumer(connection)
    except KeyboardInterrupt:
        print('Interrupted')
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)
