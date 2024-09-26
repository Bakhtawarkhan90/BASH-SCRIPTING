#!/bin/bash
# This shebang line indicates that the script should be run using the bash shell.

echo "*********************************************** Update the package index *******************************************"
sudo apt-get update

echo "*********************************************** Install Docker ***************************************************"
sudo apt-get install -y docker.io

echo "*********************************************** Add the current logged-in user to the Docker group ***************************************************"
sudo chown $USER /var/run/docker.sock
sudo usermod -aG docker $USER

echo "*********************************************** Install Docker Compose v2 ***************************************************"
sudo apt-get install docker-compose-v2

echo "*********************************************** Verify Docker Compose installation ***************************************************"
docker compose version

echo "*********************************************** Clone the repository ***************************************************"
git clone https://github.com/Bakhtawarkhan90/wanderlust.git

echo "*********************************************** Change directory to the newly cloned 'wanderlust' directory ***************************************************"
cd wanderlust

echo "*********************************************** Switch to the 'devops' branch in the 'wanderlust' repository ***************************************************"
git checkout devops

echo "*********************************************** Build and start the Docker containers defined in the docker-compose.yml file ***************************************************"
docker compose up --build -d

echo "*********************************************** Wait for Docker containers to be fully up and running ***************************************************"
sleep 10

echo "*********************************************** Import JSON data into the MongoDB container ***************************************************"
docker exec -it $(docker ps -qf "name=mongo") mongoimport --db wanderlust --collection posts --file ./data/sample_posts.json --jsonArray

echo "*********************************************** Wait for a moment before clearing the screen ***************************************************"
sleep 6

echo "*********************************************** Clear the screen ***************************************************"
clear

echo "*********************************************** Show all running Docker containers ***************************************************"
docker ps


echo "*********************************************** Now You Can Access The App On $(curl -s ifconfig.me):5173 ***************************************"
