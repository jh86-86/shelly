#!/bin/bash

# this script creates a new user on the local system

#you must supply a usrname as an argument to the script

#optionally you can provide a comment for the account as an argument

#A password will be automatically generated for the account

#the username , password and host for the account will be displayed

#make sure the script is being executed with superuser privileges

if [[ ${UID} -ne 0 ]]
then
    echo 'Please run with sudo or as root.'
    exit 1
fi

#if they dont supply at least one arguemnt, then give them help

if [[ "${#}" -lt 1 ]]
then 
    echo "Usage: ${0} USER_NAME [COMMENT]..."
    echo 'Create an account on the local system with the name of USER_NAME and a comments field of Comment'
    exit 1
fi

# The first parameter is the user name
USER_NAME="${1}"

# the rest of the parameters are the account comments
shift
COMMENT="${@}"

#Generate a password
PASSWORD=$(date +%s%N | sha256sum | head -c48)

# create the user with the password, 
#-c stands for comment
#-m stands for creation of a home directory
useradd -c "${COMMENT}" -m ${USERNAME}

#check to see if the useradd command succeeded
#we don't want to tell the user that an account was created when it hasn't been

if [[ "${?}" -ne 0 ]]
then
    echo 'The account could not be created.'
    exit 1
fi

#set the password on the account
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

#check to see if the passwd command succeeded

if [[ "${?}" -ne 0 ]]
then
    echo 'The password for the account could not be set.'
    exit 1
fi

#force password change on first login
passwd -e ${USER_NAME}

#Display the username, password, and the host where the user was created
#HOSTNAME is a built in variable in bash
echo
echo 'username'
echo "${USER_NAME}"
echo
echo 'password: '
echo "${PASSWORD}"
echo
echo 'host: '
echo "${HOSTNAME}"
exit 1
