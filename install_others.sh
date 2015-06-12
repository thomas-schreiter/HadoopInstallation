# check input arguments
if [ "$#" -ne 2 ]; then
    echo "Please specify pem-key and public_dns file" && exit 1
fi

# call other.sh on remote bash
while read line
do 
    ssh -o "StrictHostKeyChecking no" -i $1 ubuntu@$line 'bash -s' < others.sh $id ${SERVER_DNS[@]}&
done < $2

