
#!/bin/bash
 <<task
deploy a app & handle errors
task

code_clone() {
 echo "Cloning the code"
 git clone https://github.com/LondheShubham153/django-notes-app.git
}

install_req() {
 echo "Installing dependencies"
 sudo apt-get install docker.io nginx -y docker-compose
}

req_restart() {
 sudo chown $USER /var/run/docker.sock
 #sudo systemctl enable docker
 sudo systemctl enable nginx
 #sudo systemctl restart docker
}

deploy() {
 docker build . -t notes-app
 docker-compose up -d
 #docker run -d -p 8000:8000 notes-app:latest
}
echo "*************DEPLOYMENT STARTED**********"
if ! code_clone; then
 echo "the code dir already exists"
 cd django-notes-app
fi

if ! install_req; then
 echo "Installation Failed"
 exit 1
fi

if ! req_restart; then
 echo "system fault identified"
 exit 1
fi
if ! deploy; then
  echo "Sending-mail to Team Leader"
  exit 1
echo "************DEPLOYMENT DONE*************"
