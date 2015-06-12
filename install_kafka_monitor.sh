# check input arguments
if [ "$#" -ne 2 ]; then
    echo "Please specify pem-key and ip" && exit 1
fi

# execute install script on remote machine
ssh -o "StrictHostKeyChecking no" -i $1 ubuntu@$2 'bash -s' < KafkaMonitor/install.sh &
