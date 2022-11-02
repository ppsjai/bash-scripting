#!/bin/bash

#Variable Declaration
package="httpd wget unzip"
svc="httpd"
url="https://www.tooplate.com/zip-templates/2098_health.zip"
art_name="2098_health"
tempdir="/tmp/webfiles"

# Installing Dependencies
echo "###################################################"
echo "installing packages."
echo "###################################################"
sudo yum install $package -y > /dev/null
echo

# start & Enable service
echo "###################################################"
echo "Start & Enable HTTPD services"
sudo systemctl start $svc 
sudo systemctl enable $svc
echo 

#Creating temp Directory
echo "###################################################"
echo "Starting artifact Deployement"
echo "###################################################"
mkdir -p $tempdir
cd $tempdir
echo

wget $url > /dev/null
unzip art_name.zip > /dev/null
sudo cp -r art_name/* /var/www/html/
echo

#bounce service
echo "###################################################"
echo "Restarting httpd service"
echo "###################################################"
systemctl restart $svc
echo

#clean up
echo "###################################################"
echo "Removing Temporary files"
echo "###################################################"
rm -rf $tempdir
echo

sudo systemctl status $svc
ls /var/www/html/

#1.note this document for dismantle to delete all of our content
#creating a file vim---> like dismantle.sh
#!/bin/bash
sudo systemctl stop httpd
sudo rm -rf /var/www/html/*
sudo yum remove httpd wget unzip -y