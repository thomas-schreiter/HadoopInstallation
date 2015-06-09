#!/bin/bash

# get input arguments [aws region, pem-key location]
PEMLOC=$1

# check if pem-key location is valid
if [ ! -f $PEMLOC ]; then
    echo "pem-key does not exist!" && exit 1
fi

# import AWS private DNS names
SERVER_NAME=()
while read line; do
    SERVER_NAME+=($line)
done < ../private_dns

# import AWS public DNS's
SERVER_DNS=()
while read line; do
    SERVER_DNS+=($line)
done < ../public_dns

# Install Zookeeper
id=-1
for dns in "${SERVER_DNS[@]}"
do
    id=$((id+1))
    ssh -o "StrictHostKeyChecking no" -i $PEMLOC ubuntu@$dns 'bash -s' < setup_zookeeper.sh $id ${SERVER_DNS[@]}&
done

wait

# Install Kafka
id=-1
for dns in "${SERVER_DNS[@]}"
do
    id=$((id+1))
    ssh -o "StrictHostKeyChecking no" -i $PEMLOC ubuntu@$dns 'bash -s' < setup_kafka.sh $id ${SERVER_DNS[@]}&
done

