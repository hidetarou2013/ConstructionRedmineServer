#!/bin/bash

# pre operate
docker stop myredmine2_mysql_storage myredmine2_redmine_storage myredmine2_mysql myredmine2_svn myredmine2
docker rm myredmine2_mysql_storage myredmine2_redmine_storage myredmine2_mysql myredmine2_svn myredmine2

# pull method
##docker pull hidetarou2013/redmine-storage:latest 
##docker pull hidetarou2013/mysql-storage:latest 
#docker pull hidetarou2013/svn-storage:latest 
##docker pull sameersbn/redmine:latest 
#docker pull hidetarou2013/redmine:v3.3.0 
##docker pull sameersbn/mysql:latest

# build method
#docker build -t sameersbn/mysql github.com/sameersbn/docker-mysql
#docker build -t sameersbn/redmine github.com/sameersbn/docker-redmine
#docker build -t hidetarou2013/mysql-storage github.com/hidetarou2013/mysql-storage
#docker build -t hidetarou2013/redmine-storage github.com/hidetarou2013/redmine-storage
#docker build -t hidetarou2013/svn-storage github.com/hidetarou2013/svn-storage
#docker build -t hidetarou2013/redmine:v3.3.0_a github.com/hidetarou2013/ConstructionRedmineServer

# storage
docker create --name myredmine2_redmine_storage hidetarou2013/redmine-storage
docker create --name myredmine2_mysql_storage hidetarou2013/mysql-storage

# mysql
docker run --volumes-from myredmine2_mysql_storage --name=myredmine2_mysql -d -e 'DB_NAME=redmine_production'  -e 'DB_USER=redmine' -e 'DB_PASS=password' sameersbn/mysql:latest

# svn
docker run --name myredmine2_svn -t -d -v /home/vagrant/web-contents/:/var/www/html/ -p 80:80 -p 443:443 hidetarou2013/centos6-apache:SVN_repo1

# sleep
sleep 30s

# redmine
docker run --name=myredmine2 -d -t -p 10080:80 --link myredmine2_mysql:mysql --link myredmine2_svn:svn --volumes-from myredmine2_redmine_storage sameersbn/redmine

# retry
# sleep
##sleep 10s
##docker stop myredmine2
##sleep 10s
##docker rm myredmine2
##sleep 10s
##docker run --name=myredmine2 -d -t -p 10080:80 --link myredmine2_mysql:mysql --link myredmine2_svn:svn --volumes-from myredmine2_redmine_storage hidetarou2013/redmine:v3.3.0_a

# status check
docker ps -a
sleep 1s
docker ps

exit 0