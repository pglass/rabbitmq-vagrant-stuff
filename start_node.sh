#!/bin/sh

export RABBITMQ_NODE_PORT=$1
export RABBITMQ_NODENAME=$2 
export RABBITMQ_HOME=/home/vagrant/
#RABBITMQ_MNESIA_DIR=./tmp/rabbitmq-$2-mnesia
#RABBITMQ_PLUGINS_EXPAND_DIR=./tmp/rabbitmq-$2-plugins-scratch
#RABBITMQ_LOG_BASE=./tmp

#STOMP_PORT=`expr $RABBITMQ_NODE_PORT + 30`
#RABBITMQ_SERVER_START_ARGS="-rabbitmq_stomp tcp_listeners [$STOMP_PORT]"

echo "Using node port = $RABBITMQ_NODE_PORT"
echo "Using node name = $RABBITMQ_NODENAME"
#echo "Using stomp port = $STOMP_PORT"

/usr/sbin/rabbitmq-server -detached
