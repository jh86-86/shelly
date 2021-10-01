#!/bin/bash

#this script creates an account on the local system
# you will be prompted for the account anme and password

#ask for the user name
read -p 'Enter the username to create: ' USER_NAME

#ask for the real name
read -p 'Enter the name of the person who created this account is for: ' COMMENT

#ask for the password
read -p 'Enter the password for this account: ' PASSWORD

#creat the user
useradd -c "${COMMENT}" -m ${USER_NAME}


# set the password for the user
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# force the password change on the login
passwd -e ${USER_NAME}
