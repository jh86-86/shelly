#!/bin/bash


echo 'Hello'

#assign value to variable
WORD='script'


#display the var

echo "$WORD"

#demonstrate that single quotes cause vars to not get expanded
# exacrtly what is in the quotes
echo '$WORD'

#combine the vairable with hardcode text

echo "this is a shell $WORD"

#same as above different syntax

echo "This is a shell ${WORD}"

ENDING='ed'

echo "this is ${WORD}${ENDING}"

#change the value stored in ENDING VARIABLE (reassignment)

ENDING='ing'
