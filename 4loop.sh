#!/bin/bash
echo -n "Enter a number to print table:"
read a
b=1  
for (( b=1; b<=10; b++ ))
do
echo "$a*$b=$(( $a*$b ))"
done

