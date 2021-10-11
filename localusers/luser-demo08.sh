#!/bin/bash

#this script demonstrates I/O redirection

#standard input from keyboard and using pipes to pipe into other output

#standard output displayed to screen

#redirect STDOUT to a file

FILE="/tmp/data"

#head is a command
head -n1 /etc/passwd > ${FILE}

#redirect STDIN (standard input) to a program
read LINE < ${FILE}
echo "LINE contains: ${LINE}"

#rediect STDOUT to a file, overwriting file
head -n3 /etc/passwd > ${FILE}
echo
echo "Contents of ${FILE};"
cat ${FILE}

#redirect STDOUT to a file,a ppending to the file
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo
echo "Contents of ${FILE}"
cat "${FILE}"

#redirect STDIN to a program using FD 0
echo LINE <0 {FILE}
echo
echo "Line contains: ${LINE}"

#redirect STDOUT to a file using FD 1, overwriting the file
head -n3 /etc/passwd 1> ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

#redirect STDERR to a file using FD 2
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd/fakefile 2> ${ERR_FILE}

#redirect STDOUT and STERR to a file
head -n3 /etc/passwd/fakefile &> ${FILE}
echo 
echo "Contents of ${FILE}:"
cat ${FILE}