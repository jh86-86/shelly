#!/bin/bash

#this scripts demos case

# if [[ "${1}" = 'start' ]]
# then echo 'starting'
# elif [[ "${1}" = 'stop' ]]
# then
# echo 'stopping'
# elif [[ "${1}" = 'status' ]]
# then
# echo 'Status:'
# else
#     echo 'supply a valid option' >&2
# fi

#asterix is a catch all
case "${1}" in 
 start)
    echo 'starting.'
    ;;
 stop)
    echo 'stopping'
    ;;
 status)
    echo 'Status'
    ;;
 *)
    echo 'supply a valid option' >&2
    exit 1
    ;;
esac