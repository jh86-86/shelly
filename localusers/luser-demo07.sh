#!/bin/bash

#Demostrate the use of shift and while loops
echo "Parameter 1: ${1}"
echo "Parameter 1: ${2}"
echo "Parameter 1: ${3}"
echo 

#loop thorugh all positional parameters
while [[ "${#}" -gt 0 ]]
do
    echo "Number of parameters; ${#}"
    echo "Paramter 1: ${1}"
    echo "Paramter 2: ${2}"
    echo "Paramter 3: ${3}"
    echo "Paramter 4: ${4}"
    echo 
    shift
done