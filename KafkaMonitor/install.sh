
# install java, unzip, git
sudo apt-get update
sudo apt-get --yes --force-yes install openjdk-7-jdk
sudo apt-get --yes --force-yes install unzip
sudo apt-get --yes --force-yes install git

# install play
wget http://downloads.typesafe.com/typesafe-activator/1.3.4/typesafe-activator-1.3.4.zip -P ~/Downloads
sudo unzip ~/Downloads/typesafe-activator-1.3.4.zip -d /usr/local/
sudo mv /usr/local/activator* /usr/local/activator

# install kafka-web-console
git clone git://github.com/claudemamo/kafka-web-console.git ~/kafka-web-console
cd ~/kafka-web-console
nohup sudo /usr/local/activator/activator start -DapplyEvolutions.default=true 

