#!/bin/bash

# run shell
# sh create_start_redmine1.sh myredmine3 10080 v3.3.0_c
# sh create_start_redmine1.sh myredmine3 10080 2.6.4
# param1:container name
# param2:redmine port
# param3:docker image tag

# pre operate
docker stop $1_mysql_storage $1_redmine_storage $1_mysql $1_svn $1
docker rm $1_mysql_storage $1_redmine_storage $1_mysql $1_svn $1

# pull method
##docker pull hidetarou2013/redmine-storage:latest 
##docker pull hidetarou2013/mysql-storage:latest 
#docker pull hidetarou2013/svn-storage:latest 
docker pull sameersbn/redmine:$3 
#docker pull hidetarou2013/redmine:v3.3.0_b 
##docker pull sameersbn/mysql:latest

# build method
#docker build -t sameersbn/mysql github.com/sameersbn/docker-mysql
#docker build -t sameersbn/redmine github.com/sameersbn/docker-redmine
#docker build -t hidetarou2013/mysql-storage github.com/hidetarou2013/mysql-storage
#docker build -t hidetarou2013/redmine-storage github.com/hidetarou2013/redmine-storage
#docker build -t hidetarou2013/svn-storage github.com/hidetarou2013/svn-storage
#docker build -t hidetarou2013/redmine:$3 github.com/hidetarou2013/ConstructionRedmineServer/master/v3.3.0_b/Dockerfile
#docker build -t hidetarou2013/redmine:$3 ./v3.3.0_b

# storage
docker create --name $1_redmine_storage hidetarou2013/redmine-storage
docker create --name $1_mysql_storage hidetarou2013/mysql-storage

# mysql
docker run --volumes-from $1_mysql_storage --name=$1_mysql -d -e 'DB_NAME=redmine_production'  -e 'DB_USER=redmine' -e 'DB_PASS=password' sameersbn/mysql:latest

# svn
docker run --name $1_svn -t -d -v /home/vagrant/web-contents/:/var/www/html/ -p 80:80 -p 443:443 hidetarou2013/centos6-apache:SVN_repo1

# sleep
sleep 30s

# redmine
docker run --name=$1 -d -t -p $2:80 --link $1_mysql:mysql --link $1_svn:svn --volumes-from $1_redmine_storage sameersbn/redmine:$3

# retry
# sleep
##sleep 10s
##docker stop $1
##sleep 10s
##docker rm $1
##sleep 10s
##docker run --name=$1 -d -t -p $2:80 --link $1_mysql:mysql --link $1_svn:svn --volumes-from $1_redmine_storage hidetarou2013/redmine:$3

# status check
docker ps -a
sleep 1s
docker ps

# echo
echo "please type follow commands"
echo "docker stop $1"
echo "docker rm $1"
echo "docker run --name=$1 -d -t -p $2:80 --link $1_mysql:mysql --link $1_svn:svn --volumes-from $1_redmine_storage hidetarou2013/redmine:$3"

exit 0