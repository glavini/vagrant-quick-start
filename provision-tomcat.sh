#!/bin/bash

apt-get update -y
apt-get upgrade -y
apt-get install -y default-jdk

# Create a user and group named tomcat
groupadd tomcat
useradd -s /sbin/nologin -g tomcat -d /opt/tomcat tomcat
passwd tomcat

# Download and extract tomcat
mkdir /opt/tomcat
wget https://apache.dattatec.com/tomcat/tomcat-8/v8.5.70/bin/apache-tomcat-8.5.70.tar.gz
tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1

cd /opt/tomcat

# Change the owner of the tomcat directory to the tomcat user, and make all files in the bin directory executable
chown -hR tomcat:tomcat /opt/tomcat
chmod +x /opt/tomcat/bin/*
chmod +x /opt/tomcat/bin/*


# Configure Tomcat to run as a service
cp /vagrant/tomcat /etc/init.d/tomcat
sed -i -e 's/\r//g' /etc/init.d/tomcat
chmod ug+x /etc/init.d/tomcat
chown -R tomcat /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/

sudo update-rc.d tomcat defaults

service tomcat start
