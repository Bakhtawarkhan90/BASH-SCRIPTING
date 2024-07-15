#!/bin/bash
## -n is used to take input without newline 
echo -n "enter a number:"
read a
if [[ "$a" -gt 10 ]]
then
echo "******* a is greater than 10 *******"
else
echo "******* a is smaller than 10 *******"
fi
