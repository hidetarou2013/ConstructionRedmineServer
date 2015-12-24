#!/bin/bash

# pull method
sudo docker pull hidetarou2013/redmine-storage:latest 
sudo docker pull hidetarou2013/mysql-storage:latest 
sudo docker pull sameersbn/redmine:latest 
sudo docker pull sameersbn/mysql:latest

# build method
#sudo docker build -t sameersbn/mysql github.com/sameersbn/docker-mysql
#sudo docker build -t sameersbn/redmine github.com/sameersbn/docker-redmine
#sudo docker build -t hidetarou2013/mysql-storage github.com/hidetarou2013/mysql-storage
#sudo docker build -t hidetarou2013/redmine-storage github.com/hidetarou2013/redmine-storage

sudo docker create --name redmine-storage hidetarou2013/redmine-storage
sudo docker create --name mysql-storage hidetarou2013/mysql-storage
sudo docker run --volumes-from mysql-storage --name=myredmine1_mysql -d -e 'DB_NAME=redmine_production'  -e 'DB_USER=redmine' -e 'DB_PASS=password' sameersbn/mysql:latest
#sudo docker run --name=redmine -it --rm -p 10080:80 --link myredmine1_mysql:mysql --volumes-from redmine-storage sameersbn/redmine
sudo docker run --name=redmine -d -t -p 10080:80 --link myredmine1_mysql:mysql --volumes-from redmine-storage sameersbn/redmine
