#!/bin/bash

#this script generates a list of random passwords.

#random int as password
PASSWORD="${RANDOM}"
echo "${RANDOM}"

#use three random numbers all together

PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"

#use the current date/time as a basis for password
PASSWORD=$(date +%s)
echo "${PASSWORD}"

# use the nanoseconds to act as randomization
PASSWORD=$(date +%s%N)

#a better password sha256sum is for password hashing, head -32 specifies in this case how many chars
PASSWORD=$(date +%s%N | sha256sum | head -c32)
echo "${PASSWORD}"

# even better password than before
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
echo "${PASSWORD}"

#append special character to the password
SPECIAL_CHARACTER=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)
echo "${PASSWORD}${SPECIAL_CHARACTER}"