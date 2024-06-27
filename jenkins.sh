#!/bin/bash

# First, update package lists to ensure we have the latest information
echo "*************** Updating package lists ***************"
sudo apt-get update -y

# Install the current version of Java because Jenkins requires it
# The current version of Java is 17
echo "*************** Installing Java for Jenkins ***************"
sudo apt-get install -y fontconfig openjdk-17-jre openjdk-17-jre-headless

# Adding key for Jenkins repository
echo "*************** Adding key for Jenkins repo ***************"
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Adding repository for automated installation
echo "******************** Adding repository for automated installation ********************"
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Updating the system to apply changes
echo "******************** Updating your system to apply changes ********************"
sudo apt-get update -y

# Installing dependencies to avoid unmet dependencies issues
echo "******************** Installing dependencies to avoid unmet dependencies issues ********************"
sudo apt-get install -y net-tools

# Installing Jenkins
echo "******************** Installing Jenkins ********************"
sudo apt-get install -y jenkins

# Displaying the currently installed Java version
echo "******************** Currently installed Java version is ********************"
java --version

# Adding the currently logged-in user to the Jenkins group
echo "******************** Adding currently logged-in user to Jenkins group ********************"
sudo usermod -aG jenkins $USER

# Ensuring that the current user has been added to the Jenkins group
echo "******************** Ensuring that the current user has been added to the Jenkins group ********************"
getent group jenkins

# Displaying Jenkins administrator password
echo "******************** Your Jenkins Administrator Password is below ********************"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Jenkins is running on the default port 8080
echo "******************** Jenkins is now running on default port 8080 ********************"

# Downloading Docker and Docker Compose
echo "****************************** Installing Docker and Docker Compose **************************"
sudo apt update && sudo apt install -y docker.io docker-compose

# Adding the currently logged-in user and Jenkins user to the Docker group
echo "****************************** Adding users to Docker group **************************"
sudo chown $USER /var/run/docker.sock
sudo usermod -aG docker $USER && sudo usermod -aG docker jenkins

# Starting SonarQube Container
# Uncomment the following lines to start SonarQube
# echo "****************************** Starting SonarQube Container **************************"
# docker run -itd --name sonar -p 9000:9000 sonarqube:lts-community-alpine
# docker start sonar
