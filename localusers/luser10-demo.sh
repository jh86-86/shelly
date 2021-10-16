#!/bin/bash
#function
#local shell built in, only used in a function
# is first agrument
log(){
    local MESSAGE="${@}"
    if [[ "${VERBOSE}" = 'true' ]]
    then
        echo "${MESSAGE}"
    fi
    #sends a message to syslog and standard output if VERBOSE is true
    logger -t luser10-demo.sh "${MESSAGE}"
}

backup_file(){
    #creates a backip file. returns non-zero status on error

    local FILE="${1}"
    #make sure file exists
    if [[ -f "${FILE}" ]]
    then    
        local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
        log "Back up ${FILE} to ${BACKUP_FILE}"

        #exit status of the function will be the exit status of the cp command
        cp -p ${FILE} ${BACKUP_FILE}
        else
        #if file doesnt exist can't make backop
        return 1
        fi

}

#verbosity is the first argument
readonly VERBOSITY='true' #readonly is like a const variable

log "${VERBOSITY}" 'Hello'     
log  'This is fun!'


backup_file 'etc/passwd'


