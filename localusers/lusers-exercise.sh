#!/bin/bash
# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
    echo "Please return as sudo or as root" 1>&2
    exit 1
fi

#if the user doesn't supply at least one argument, then give them help
if [[ "${#}" -lt 1 ]]
then 
    echo "Usage: ${0} USER_NAME [COMMENT]..." >&2
    echo 'Create an account on the local system witht he name of USER_NAME and a comments field of comment'
    exit 1
fi


# Get the username (login).
read -p "Enter your username: : " USER_NAME

# Get the real name (contents for the description field).
read -p "Enter your real name: " REAL_NAME

# Get the password.
read -p "Enter your password: " COMMENT 

# Create the user with the password.
useradd -c "${REAL_NAME}" -m "${USER_NAME}" &> /dev/null
# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then 
 echo 'The account could not be created.'
    exit 1
fi

# Set the password.
echo ${COMMENT} | passwd --stdin ${USER_NAME} &> /dev/null

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then 
    echo 'The password for the account could not be set' >&2
    exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME} >&2 /dev/null

# Display the username, password, and the host where the user was created.
echo "Username: ${USER_NAME}, Password: ${COMMENT}, Host: ${HOSTNAME}"

exit 0