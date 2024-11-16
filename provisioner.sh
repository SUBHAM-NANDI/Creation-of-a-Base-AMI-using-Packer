#!/usr/bin/env bash
sudo yum update -y

#install cloudwatch agent
#1. download the rpm 
wget https://amazoncloudwatch-agent.s3.amazonaws.com/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm -y
#2. install
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb
#3. start the agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a start
#4. enable the agent to start on boot
sudo systemctl enable amazon-cloudwatch-agent
#5. status check
sudo systemctl status amazon-cloudwatch-agent

#install aws ssm agent
#1. install the package
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm 
#2. status check
sudo systemctl status amazon-ssm-agent

#install docker
#1. insatall docker
sudo yum install -y docker
#2. start docker services
sudo systemctl start docker
#3. enable docker to start on boot
sudo systemctl enable docker
#4. check docker version
docker --version

#install git client
sudo yum install git -y

#install aws inspector
wget https://inspector-agent.amazonaws.com/linux/latest/install
sudo bash install