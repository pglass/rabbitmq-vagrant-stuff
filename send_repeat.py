#!/usr/bin/python
import pika
import time
import sys

if len(sys.argv) < 2:
    print "Usage: %s <host> <port>" % sys.argv[0]
    sys.exit(1)

host = sys.argv[1]
port = int(sys.argv[2])

print "Using host %s and port %s" % (host, port)

connection = pika.BlockingConnection(
    pika.ConnectionParameters(host=host,
                              port=port)
)
channel = connection.channel()

# Need to make sure the recipient queue exists.
# If a message is sent to a non-existant location, 
# RabbitMQ "trashes" the message.
#
# This is idempotent. The sender and receiver should both declare the queue.
# Only one queue is ever created.
channel.queue_declare(queue='hello')

# A message can never be sent directly to the queue. 
# Instead, the message is sent to an "exchange". 
# Here we use the default exchange.
count = 1
while True:
    channel.basic_publish(exchange='',
                          routing_key='hello',
                          body='Hello World %s' % count)
    print "Sent message %s" % count
    time.sleep(5)
    count += 1

connection.close()
