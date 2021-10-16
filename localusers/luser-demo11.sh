#!/bin/bash


#make script generate password.

#the user can set the passowrd lenght with -l andd add special characters with -s
#verbose mode can be enabled with -v
usage(){
    echo "Usage: ${0} [-vs] [-l length]" >&2
    echo 'Genetate a random password.'
    echo ' -l LENGTH specify length of password'
    echo ' -s Append a spcial character to password'
    echo ' -v Increase verbosity'
    exit 1
}

log(){
    #local variable which catches anything passed into this function
    local MESSAGE=${@}
if [[ "${VERBOSE}" = 'true' ]]
then
    echo "${MESSAGE}"
fi
}



#set a default password length
LENGTH=48


while getopts vl:s OPTION
do
    case ${OPTION} in
    v)
        VERBOSE='true'
        log 'Verbose mode on.'
        ;;
    l)
        LENGTH="${OPTARG}"
        ;;
    s)
        USE_SPECIAL_CHARACTER='true'
        ;;
        # ? is a catch all illegal characters and returns usage function with information in it
    ?)
        usage
        ;;
    esac
done

echo "NUmber of args: ${#}"
echo "All args ${@}"
echo "first arg ${1}"
echo "first arg ${2}"
echo "first arg ${3}"

#Inspect OPTIND
echo "OPTIND ${OPTIND}"



log 'Generating a password'
PASSWORD=$(data +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]
then
    log 'Select a random special character'
    SPECIAL_CHARACTER=$(echo '!@#%$()*_+)' | fold -w1 | shuf |head -c1)
    PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi

log "done."
log 'Here is the password:'

echo "${PASSWORD}"

exit 0


