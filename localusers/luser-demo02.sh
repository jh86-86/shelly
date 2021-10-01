#¡/bin/bash

# Display the UID and the username of the user executing this script
# Display if the user is the root user or not

#Display UID
echo "YOUR UID ${UID}"


#Display Username
USER_NAME=$(id -un)
#same as above syntax
USER_NAME=`id -un`
echo Your is username is: ${USER_NAME}""


#Display if the user is the root user or not

#if uid === 0
if [[ "${UID}" -eq 0 ]]
then
    echo 'You are root.'
else
    echo 'You are not root'
fi
