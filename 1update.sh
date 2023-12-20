#!/bin/bash

hostname
echo "welcome hostname"
#"this command is used to update the system."
 sudo apt-get update
sleep 3
echo "###########################################################################################"
# "this command is used to list all files in a direstory."
echo "list of all files"
 ls
echo "###########################################################################################"
# "this command is used to show the present working directory."
echo "you are in"
 pwd
echo "###########################################################################################"
# "this command is used to show the memory info."
echo "this is system memory information"
free -m
echo "###########################################################################################"
# "this command is used to show the disk usage."
echo "this is system dick usage"
df -h
#echo "###########################################################################################"
