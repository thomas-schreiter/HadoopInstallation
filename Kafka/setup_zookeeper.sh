#!/bin/bash

# install and configure hadoop
sudo apt-get update
sudo apt-get --yes --force-yes install openjdk-7-jdk

#install zookeeper
wget http://mirror.cc.columbia.edu/pub/software/apache/zookeeper/stable/zookeeper-3.4.6.tar.gz -P ~/Downloads
sudo tar zxvf ~/Downloads/zookeeper-*.tar.gz -C /usr/local
sudo mv /usr/local/zookeeper-3.4.6/ /usr/local/zookeeper

# create config file 
cp /usr/local/zookeeper/conf/zoo_sample.cfg /usr/local/zookeeper/conf/zoo.cfg

# set my id
sudo mkdir /var/lib/zookeeper
sudo rm /var/lib/zookeeper/myid
sudo touch /var/lib/zookeeper/myid
echo "echo $1 >> /var/lib/zookeeper/myid" | sudo -s

# configure data directory
sed -i 's/dataDir=\/tmp\/zookeeper/dataDir=\/var\/lib\/zookeeper/g' /usr/local/zookeeper/conf/zoo.cfg

# configure servers
SERVERS='clientPort=2181'
shift
id=-1
while test ${#} -gt 0
do
   id=$((id+1))
   SERVERS+="\nserver.$id=$1:2888:3888"
   shift
done
sed -i "s/clientPort=2181/$SERVERS/g" /usr/local/zookeeper/conf/zoo.cfg

# start zookeeper
sudo /usr/local/zookeeper/bin/zkServer.sh start
 
