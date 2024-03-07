#!/bin/bash
# first install current version of java beacause without java jenkins will not work
# now, current version of java is 17
echo "*************** Installing java for jenkins ***************"
#sudo apt-get install openjdk-17-jdk -y
sudo apt-get install fontconfig openjdk-17-jre -y
# adding key for repository
echo "*************** Adding key for jenkins repo ***************"
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key


# adding repository for automate installation
echo "******************** Adding repository for automate installation ********************"
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# now, update your system once again
echo "******************** Updating your system to apply changes ********************"
sudo apt-get update -y

# now ,finally install jenkins
echo "******************** Installing Jenkins ********************"
sudo apt-get install jenkins -y


echo "******************** Currently installed java version is ********************"
java --version


#now, adding user in jenkins group
echo "******************** Adding currently loggedin user to jenkins group ********************"
sudo usermod -aG jenkins $USER


# now, checking group list
# echo "******************** Ensureing that the current user will be addded to Jenkins groups ********************"
cat /etc/group


# now, see the jenkins status
echo "******************** Checking the status of jenkins ********************"
sudo systemctl is-active jenkins

# showing password
echo "******************** Your Jenkins Administrator Password is Showing Below ********************"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# port
echo "******************** Jenkins in now running on default port 8080 ********************"
