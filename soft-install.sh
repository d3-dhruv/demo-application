1. Configure Ubuntu Node for Jenkins
2. Run below below command to configure


3.
sudo apt update
sudo apt install openjdk-17-jdk -y

# Installing Jenkins
Install Jenkins


sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
sudo systemctl enable jenkins


5. Plugins to be Installed
   a. Pipeline: Stage View
   b. SonarQube Scanner
   c. Pipeline Maven Integration
   d. Docker plugin
   e. SonarQube Scanner for Jenkins
   f. Nexus Repository Manager plugin
   g. Kubernetes plugin
   


6. Create Pipeline job

7. create a credentials in Jenkins, Docker, GitHub, Sonarqube, Nexus

8. Configure sonarqube Webhook for Jenkins and generate token 

9. Maven Build
    1. Configure Maven in tools section of Jenkins -> Manage


10. Install Trivy
 sudo apt-get install wget gnupg
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy -y



11. Go to Ubuntu
  run--> sudo visudo

  # provide full access to the jenkins user
  jenkins ALL=(ALL) NOPASSWD: ALL


# installing docker
12. Docker Install
#Docker
curl https://get.docker.com | bash
sudo usermod -aG docker $USER
newgrp docker
sudo systemctl stop docker 4
sudo systemctl enable --now docker 
sudo systemctl start docker

Login with jenkins user and run as below

sudo usermod -aG docker $USER


stop jenkins and start jenkins

use root
systemctl stop jenkins
systemctl start jenkins
systemctl enable docker

13. Run Sonarqube as a Container

mkdir sonar
sudo chown -R 1000:1000 /home/ubuntu/sonar
sudo chmod -R 755 /home/ubuntu/sonar

14. Install sonar scanner plugin

15. Run Nexus as container

#Give 777 for /home/ubuntu/nexus
sudo chown -R 200:200 /home/ubuntu/nexus
sudo chmod -R 755 /home/ubuntu/nexus

docker run -d \
  --name nexus \
  -p 8081:8081 \
  -v /home/ubuntu/nexus:/nexus-data \
  sonatype/nexus3:latest


4. Configure Jenkins (userid, install plugins)


# push artifact to nexus repository
# push image to docker
# scan docker image
# Installing AWS CLI

#!/bin/bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install

# Installing Kubectl

#!/bin/bash
sudo apt update
sudo apt install curl -y
sudo curl -LO "https://dl.k8s.io/release/v1.28.4/bin/linux/amd64/kubectl"
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client

# Installing eks cluster
eksctl create cluster --name my-eks-cluster --region us-east-1 --nodegroup-name my-nodegroup --node-type t2.small --nodes 3 --nodes-min 1 --nodes-max 5 --managed

# server cluster url
kubectl cluser-info

# configure kubectl getting kub configuration file for cluster
 cd .kube/
cat config

