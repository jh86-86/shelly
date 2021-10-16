#!/bin/bash

readonly ARCHIVE_DIR='/archive'

usage(){
#dispaly the usage exit   //optional option
echo "Usage: ${0} [-dra] USER [USERN] ..." >&2
echo "Disable a local linux account" >&2
echo ' -d deletes accounts instead of disabling them.' >&2
echo ' -r Removes the home directory associated with the account(s)' >&2
echo ' -a Creates an archive of the home directory associated with the account(s)' >&2
exit 1
}

# script disables,deletes,  and/or archives user on local system

#make sure script is being executed with superuser priveleges
if [[ "${UID}" -ne 0 ]]
then    
    echo 'please run with sudo or root' >&2
    exit 1
fi

#parse the options
while getopts dra OPTION
do  
    case ${OPTION} in
    d) DELETE_USER='true' ;;
    r) REMOVE_OPTION='-r' ;;
    a) ARCHIVE='true' ;;
    #any other option
    ?) usage ;;
    esac
done


#remove the options while leaving the remaing arguments

shift "$(( OPTIND -1 ))"

#if the user doesn't supply argument, give them help
if [[ "${#}" -lt 1 ]]
then 
    usage
fi

#loop through all user names that were supplied as arguments

for USERNAME in "${@}"
do
    echo "Processing user: ${USERNAME}"

    #mkae sure UID of the account is at least 1000
    USERID=$(id -u ${USERNAME})
    if [[ "${USERID}" -lt 1000 ]]
    then
        echo "Refusing to remove the ${USERNAME} account with UID ${USERID}" >&2
        exit 1
    fi

#Create an archive if requested to do so.
if [[ "${ARCHIVE}" = 'true' ]]
then 
    #Make sure the ARCHIVE_DIR directory exists -d is directory
    if [[ ! -d "${ARCHIVE_DIR}" ]]
    then 
        echo "Creating ${ARCHIVE_DIR} directory"
        # -p add the parent directory to the archive
        mkdir -p ${ARCHIVE_DIR}
        if [[ "${?}" -ne 0 ]]
        then
            echo "The archive directory ${ARCHIVE_DIR} could not be created" >&2
            exit 1
        fi
    fi

#Archive the user's home directory and move it into the ARCHIVE_DIR
HOME_DIR="/home/${USERNAME}"
ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"
if [[ -d "${HOME_DIR}" ]]
then
    echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
    tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
    if [[ "${?}" -ne 0 ]]
    then
        echo "Could not create ${ARCHIVE_FILE}". >&2
        exit 1
    fi
else
    echo "${HOME_DIR} does not exist or is not a directory" >&2
    exit 1
fi
fi

if [[ "${DELETE_USER}" = 'true' ]]
then
    #Delete the user
    userdel ${REMOVE_OPTION} ${USERNAME}

    #check to see if the userfel command succeeded
    #we don't want to tell user that an account got deleted when it hasn't been

    if [[ "${?}" -ne 0 ]]
    then
        echo "the account ${USERNAME} was not deleted" >&2
        exit 1
    fi
    echo "the account ${USERNAME} was deleted"
    else
    #disabled account
     chage -E 0${USERNAME}
     if [[ "${?}" -ne 0 ]]
     then
        echo "the account ${USERNAME} was not disabled" >&2
        exit 1
     fi
    echo "The account was ${USERNAME was disabled}"
    fi
done

exit 0




    