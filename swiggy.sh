#!/bin/bash
# This shebang line indicates that the script should be run using the bash shell.

echo "*********************************************** Update the package index *******************************************"
sudo apt-get update

echo "*********************************************** Install Docker ***************************************************"
sudo apt-get install -y docker.io

echo "*********************************************** Add the current logged-in user to the Docker group ***************************************************"
sudo chown $USER /var/run/docker.sock
sudo usermod -aG $USER && newgrp docker
echo "*********************************************** Clone the repository ***************************************************"
git clone https://github.com/Bakhtawarkhan90/Swiggy.git

echo "*********************************************** Change directory to the newly cloned 'wanderlust' directory ***************************************************"
cd Swiggy

echo "*********************************************** start the Docker containers defined in the docker-compose.yml file ***************************************************"
docker run -d --name swiggy -p 3000:3000 bakhtawar375/swiggy:latest

echo "*********************************************** Wait for Docker containers to be fully up and running ***************************************************"
sleep 5

echo "*********************************************** Clear the screen ***************************************************"
clear

echo "*********************************************** Show all running Docker containers ***************************************************"
docker ps

echo "*********************************************** Now You Can Access The App On $(curl -s ifconfig.me):3000 ***************************************"
