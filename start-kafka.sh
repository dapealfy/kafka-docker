#!/bin/bash

# Start Zookeeper
bin/zookeeper-server-start.sh config/zookeeper.properties &

# Wait for Zookeeper to start
sleep 10

# Start Kafka
bin/kafka-server-start.sh config/server.properties
