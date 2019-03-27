#!/bin/bash

# any future command that fails will exit the script
set -e

# Lets write the public key of our aws instance
eval $(ssh-agent -s)
echo "$PRIVATE_KEY" | tr -d '\r' | ssh-add - > /dev/null

# ** Alternative approach
# echo -e "$PRIVATE_KEY" > /root/.ssh/id_rsa
# chmod 600 /root/.ssh/id_rsa
# ** End of alternative approach

# disable the host key checking.
bash ./deploy/disableHostKeyChecking.sh

# we have already setup the DEPLOYER_SERVER in our gitlab settings which is a
# comma seperated values of ip addresses.
DEPLOY_SERVERS=$DEPLOY_SERVERS_PROD

# lets split this string and convert this into array
# In UNIX, we can use this commond to do this
# ${string//substring/replacement}
# our substring is "," and we replace it with nothing.
ALL_SERVERS=(${DEPLOY_SERVERS//,/ })
echo "ALL_SERVERS ${ALL_SERVERS}"

# Lets iterate over this array and ssh into each EC2 instance
# Once inside the server, copy all files and run artisan commands
for server in "${ALL_SERVERS[@]}"
do
  echo "deploying to ${server}"
  ssh ${USER_NAME_PROD}@${server} "cd ${DESTINATION_DIR_PROD}; if [ ! -d "vendor" ]; then doesnotexists=1; fi"
  rsync -auv -e ssh $(pwd)/${SOURCE_DIR_PROD} ${USER_NAME_PROD}@${server}:${DESTINATION_DIR_PROD}
  # scp -r $(pwd)/* ${USER_NAME_PROD}@${server}:/var/www/iris_test/
  ssh ${USER_NAME_PROD}@${server} "cd ${DESTINATION_DIR_PROD}; if [ ! -z "$doesnotexists" ]; then php artisan key:generate; php artisan storage:link; php artisan passport:install; fi"
  ssh ${USER_NAME_PROD}@${server} "cd ${DESTINATION_DIR_PROD}; php artisan migrate; php artisan config:cache; php artisan route:cache;"
done

