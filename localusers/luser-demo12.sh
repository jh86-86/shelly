#!/bin/bash

#this deletes a user

#run as root

#if user is not equal to 0
if [[ "${UID}" -ne 0 ]]
then 
    echo 'Please run with sudo or as root' >&2
    exit 1
fi

#assume first argument is the user to delete
USER="${1}"

#delete user
userdel ${USER}

#make sure user got delete
if [[ "${?}" -ne 0 ]]
then 
    echo "The account ${USER} was NOT deleted"
    exit 1
fi

# tell the user the account was deleted
echo "The account ${USER} was deleted"
exit 0


