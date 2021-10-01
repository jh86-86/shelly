#!/bin/bash

#dispaly the UID and username of the user executing this script
#display if hte user is the vagrant user or not

#display the UID
echo "${UID}"

#only displau if hte UID does not match1000
UID_TO_TEST_FOR='1000'
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
    echo "Your uid does not match ${UID_TO_TEST_FOR}"
    exit 1
fi

#display username
USER_NAME=$(id -un)  

#test if the command succeeded
if [[ "${?}" -ne 0 ]]
then 
    echo 'The id command did not execute successfully'
    exit 1
fi    
echo "Your username is ${USER_NAME}"

#you cna use a string test condiitonal
USER_NAME_TO_TEST_FOR='vagrant'
if [[ "${USER_NAME}" = "${USER_NAME_TO_TEST_FOR}" ]]
then
    echo "Your username matches ${USER_NAME_TO_TEST_FOR}."
fi

#test for !=(not equal) for the string
if [[ "${USER_NAME}" != "${USER_NAME_TO_TEST_FOR}" ]]
then
    echo "Your username does not match ${USER_NAME_TO_TEST_FOR}."
    exit 1
fi

#says script completed successfully
exit 0