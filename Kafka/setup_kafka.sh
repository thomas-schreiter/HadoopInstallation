#!/bin/bash

# install Kafka
wget http://apache.claz.org/kafka/0.8.2.1/kafka_2.9.1-0.8.2.1.tgz -P ~/Downloads
sudo tar zxvf ~/Downloads/kafka_*.tgz -C /usr/local
sudo mv /usr/local/kafka_* /usr/local/kafka

# replace broker id
sudo sed -i "s/broker.id=0/broker.id=$1/g" /usr/local/kafka/config/server.properties

# replace advertised.host.name
BEFORE='#advertised.host.name=<hostname routable by clients>'
AFTER="advertised.host.name=$2"
sudo sed -i "s/$BEFORE/$AFTER/g" /usr/local/kafka/config/server.properties
echo $AFTER
 
# replace zookeeper connect
SERVERS=''
shift
id=-1
while test ${#} -gt 0
do
   id=$((id+1))
   SERVERS+="$1:2181,"
   shift
done
sudo sed -i "s/zookeeper.connect=localhost:2181/zookeeper.connect=$SERVERS/g" /usr/local/kafka/config/server.properties

# start kafka
sudo /usr/local/kafka/bin/kafka-server-start.sh /usr/local/kafka/config/server.properties &

# test kafka
/usr/local/kafka/bin/kafka-topics.sh --describe --zookeeper localhost:2181 

