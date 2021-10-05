#!/bin/bash

#script generates random password for each user specified on command line

#display what user typed on command line
echo "You executed this command: ${0}"

# display path and filename of script
echo "You used $(dirname $ {0}) as the path to the $(basename ${0})"

#tell user how many arguments they passed in
#(inside hte script they are parameters,outside they are arguments)
NUMBER_OF_PARAMETERS="${#}"
echo "You supplied ${NUMBER_OF_PARAMETERS} arguments on the command line"

#Make sure they supply at least one argument
if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]
then
    echo "Usage: ${0} USER_NAME [USER_NAME]"
    exit 1
fi

#generate and display a password for each parameter
for USER_NAME in "${@}"
do
    PASSWORD=$(date +%s%N |sha256sum | head -c48)
    echo "${USER_NAME}: ${PASSWORD}"
done

#treats everything as one argument
for USER_NAME in "${*}"
do
    PASSWORD=$(date +%s%N |sha256sum | head -c48)
    echo "${USER_NAME}: ${PASSWORD}"
done

 